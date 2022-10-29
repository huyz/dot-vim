""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Convenience functions {{{1

" Checks if given string starts with given substring
function! StartsWith(longer, shorter) abort
    return a:longer[0:len(a:shorter)-1] ==# a:shorter
endfunction

function! s:IsInsertLikeMode(mode) abort
    return index(['map!', 'noremap!', 'imap', 'inoremap', 'cmap', 'cnoremap', 'lmap', 'lnoremap'], a:mode) >= 0
endfunction

" Returns a RHS prefix for given mode
function! s:RhsPrefixForMode(rhs, mode) abort
    if !StartsWith(a:rhs, '<Cmd>')
        if a:mode == 'tmap' || a:mode == 'tnoremap'
            return '<C-\><C-N>'
        elseif s:IsInsertLikeMode(a:mode)
            return '<C-o>'
        endif
    endif
    return ''
endfunction
" Returns a list of RHS prefixes for insert-like and terminal mode, if
" necessary
function! s:RhsPrefixesForAllModes(rhs) abort
    if !StartsWith(a:rhs, '<Cmd>')
        return ['<C-o>', '<C-\><C-N>']
    endif
    return ['', '']
endfunction

function! s:MetaNeedsNormalization(str) abort
    if has("nvim") || (has("gui_macvim") && has("gui_running") && !&macmeta)
        return 0
    endif
    return strlen(a:str) == 5 && StartsWith(a:str, '<M-') ||
                \ (a:str == '<M-lt>')
endfunction

" There are some cases where using <Esc>x is necessary over <M-x>
" - for MacVim GUI, unless `macmeta` is on: https://github.com/macvim-dev/macvim/issues/1321
" - for iTerm vim, unless this is set:
"   xterm control sequence can enable modifyOtherKeys mode"
"
" NOTE:
" - in iTerm, it's preferable to have modifyOtherKeys to on, because that way,
"   keymaps will work in insert-like modes too (if modifyOtherKeys is off, then
"   <Esc>x keymaps would conflict with the <Esc> used to exit insert mode)
" - in MacVim GUI, it is preferable to not have `macmeta` for the same reason
"   as prefering iTerm to have modifyOtherKeys set to on.
function! s:NormalizeMetaModifier(str) abort
    if has("nvim") || (has("gui_macvim") && has("gui_running") && !&macmeta)
        return a:str
    endif
    if a:str == '<M-lt>'
        return '<Esc><lt>'
    elseif a:str == '<M->>'
        return '<Esc><gt>'
    endif
    return substitute(a:str, '<M-\(.\)>', '<Esc>\1', '')
endfunction

" Allows mapping aliases for characters like `å` to `<M-a>`
function! MapAlias(keys, rhs, modes = 'all') abort
    let l:modes = a:modes
    let l:rhs = s:NormalizeMetaModifier(a:rhs)
    if type(l:modes) == type("") && l:modes == 'all'
        execute 'map'  a:keys l:rhs
        " Exclude insert mode because we don't want the <Esc> to slow down exiting insert mode
        if !StartsWith(a:keys, '<Esc>')
            execute 'map!' a:keys l:rhs
        endif
        execute 'tmap' a:keys l:rhs
    else
        for mode in l:modes
            execute mode a:keys l:rhs
        endfor
    endif
endfunction

" Maps the key sequence to RHS, optionally with specific modes
" 'all' modes implies: map, imap, tmap (so no cmap or lmap)
function! MapKey(keys, rhs, modes = "all", no_insert = v:false, no_remap = v:true) abort
    let l:keys = a:keys
    let l:rhs = a:rhs
    let l:modes = a:modes

    " 1) If nvim, then we don't change anything
    " 2) If MacVim GUI, then we normalize and try again
    " 3) If vim TUI, then we do two mappings: one normalized and one
    "    unchanged. That's because we don't know if iTerm has modifyOtherKeys
    "    on or not.
    let l:lhs_needs_norm = s:MetaNeedsNormalization(a:keys)
    if !has("nvim") && (l:lhs_needs_norm || s:MetaNeedsNormalization(a:rhs))
        let l:no_insert = a:no_insert
        if l:lhs_needs_norm
            " If we're automatically normalizing to <Esc>, we don't want to
            " map any insert-like mode because we don't want conflict with
            " <Esc> key to get out of normal mode.
            let l:no_insert = v:true
        endif
        call MapKey(s:NormalizeMetaModifier(a:keys),
                    \ s:NormalizeMetaModifier(a:rhs), l:modes, l:no_insert,
                    \ a:no_remap)
        if has("gui_running")
            return
        endif
    endif

    let l:nore = a:no_remap ? 'nore' : ''

    let l:prefixes = s:RhsPrefixesForAllModes(l:rhs)
    if type(l:modes) == type("") && l:modes == 'all'
        execute l:nore . 'map'  l:keys l:rhs
        execute 't' . l:nore . 'map' l:keys l:prefixes[1] . l:rhs
        if a:no_insert == 0
            execute 'i' . l:nore . 'map' l:keys l:prefixes[0] . l:rhs
        endif
    else
        for mode in l:modes
            if a:no_insert == 0 || !s:IsInsertLikeMode(mode)
                execute mode l:keys s:RhsPrefixForMode(l:rhs, mode) . l:rhs
            endif
        endfor
    endif
endfunction

" Maps both the Option (⌥) and Command (⌘) versions for universal
" access and easy GUI access
function! MapSuperKey(key, rhs, modes = "all", no_insert = v:false, no_remap = v:true) abort
    call MapKey('<M-' . a:key . '>', a:rhs, a:modes, a:no_insert, a:no_remap)
    if has("gui_running")
        let l:extra_modifier = a:key >= 'A' && a:key <= 'Z' ? 'S-' : ''
        call MapKey('<' . l:extra_modifier . 'D-' . tolower(a:key) . '>',
            \ a:rhs, a:modes, a:no_insert, a:no_remap)
    endif
endfunction

