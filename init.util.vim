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

" There are some cases where using <Esc>x is necessary over <M-x>
" - for MacVim GUI, unless `macmeta` is on: https://github.com/macvim-dev/macvim/issues/1321
" - for iTerm vim, unless this is set:
"   xterm control sequence can enable modifyOtherKeys mode"
"
" NOTE:
" - in iTerm, it's preferable to have modifyOtherKeys on, because that way,
"   keymaps will work in insert-like modes too (if modifyOtherKeys is off, then
"   <Esc>x keymaps would conflict with the <Esc> used to exit insert mode; also
"   vmaps <Esc><Up> interfere for when you're trying to exit out of visual mode
"   and quickly use an arrow key)
" - in MacVim GUI, it is preferable to not have `macmeta` for the same reason
"   as preferring iTerm to have modifyOtherKeys set to on.
"   XXX 2022-11-13 I'm not sure if this is true; maybe it's because of the way I coded it; but I
"     don't want to try to fix it and go through another full round of testing.
function! s:NormalizeMetaModifier(str) abort
    if has("nvim") || (has("gui_macvim") && (exists("g:gui_running") || g:use_extended_keys_in_terminal))
        return a:str
    endif
    let l:str = substitute(a:str, '<M->>', '<Esc><gt>', 'g')
    " We don't touch keys with multiple modififers
    let l:str = substitute(l:str, '<M-\(.[^->]\+\)>', '<Esc><\1>', 'g')
    return substitute(l:str, '<M-\(.\)>', '<Esc>\1', 'g')
endfunction

" Allows mapping aliases for characters like `å` to `<M-a>`
function! MapAlias(keys, rhs, modes = 'all', no_insert = v:false) abort
    let l:modes = a:modes
    let l:rhs = s:NormalizeMetaModifier(a:rhs)
    if type(l:modes) == type("") && l:modes == 'all'
        execute 'map'  a:keys l:rhs
        " Exclude insert mode because we don't want the <Esc> to slow down exiting insert mode
        if !a:no_insert && !StartsWith(a:keys, '<Esc>') && !StartsWith(a:keys, '')
            execute 'map!' a:keys l:rhs
        endif
        execute 'tmap' a:keys l:rhs
    else
        for mode in l:modes
            if !a:no_insert || !s:IsInsertLikeMode(mode)
                execute mode a:keys l:rhs
            endif
        endfor
    endif
endfunction

" Maps the key sequence to RHS, optionally with specific modes
" - modes: 'all' implies: map, imap, tmap (so no cmap or lmap)
" - no_insert: filters modes to exclude insert-like modes. See s:IsInsertLikeMode
" - remap: only applies to modes='all'
function! MapKey(keys, rhs, modes = "all", no_insert = v:false, remap = v:false, map_flag = '') abort
    let l:keys = a:keys
    let l:rhs = a:rhs
    let l:modes = a:modes

    " 1) If nvim, then we don't change anything
    " 2) If MacVim GUI, then we normalize and try again
    " 3) If vim TUI, then we do two mappings: one normalized and one
    "    unchanged. That's because we don't know if iTerm has modifyOtherKeys
    "    on or not.
    if !has('nvim')
        let l:lhs_normalized = s:NormalizeMetaModifier(a:keys)
        let l:rhs_normalized = s:NormalizeMetaModifier(a:rhs)
        if l:lhs_normalized != a:keys || l:rhs_normalized != a:rhs
            " If we're automatically normalizing to <Esc>, we don't want to
            " map any insert-like mode because we don't want conflict with
            " <Esc> key to get out of normal mode.
            let l:no_insert = l:lhs_normalized != a:keys || a:no_insert
            call MapKey(l:lhs_normalized, l:rhs_normalized,
                        \ l:modes, l:no_insert, a:remap, a:map_flag)
            if exists("g:gui_running")
                return
            endif
        endif
    endif

    let l:nore = a:remap ? '' : 'nore'

    let l:prefixes = s:RhsPrefixesForAllModes(l:rhs)
    if type(l:modes) == type("") && l:modes == 'all'
        execute l:nore . 'map' a:map_flag l:keys l:rhs
        execute 't' . l:nore . 'map' a:map_flag l:keys l:prefixes[1] . l:rhs
        if !a:no_insert
            execute 'i' . l:nore . 'map' a:map_flag l:keys l:prefixes[0] . l:rhs
        endif
    else
        for mode in l:modes
            if !a:no_insert || !s:IsInsertLikeMode(mode)
                execute mode a:map_flag l:keys s:RhsPrefixForMode(l:rhs, mode) . l:rhs
            endif
        endfor
    endif
endfunction

function s:ShiftModifierIfNeededForSuper(key)
    let l:key = substitute(a:key, '.*-', '', '')
    return strlen(l:key) == 1 && l:key >=# 'A' && l:key <=# 'Z' ||
        \ index(['{', '}', '"', '+'], l:key) >= 0 ? 'S-' : ''
endfunction
function s:ShiftModifierIfNeededForControl(key)
    let l:key = substitute(a:key, '.*-', '', '')
    return strlen(l:key) == 1 && l:key >=# 'A' && l:key <=# 'Z' ? 'S-' : ''
endfunction

" Maps the Command (⌘) key, or in TUIs the fallback Option (⌥), key.
" That's because terminals like iTerm swallow up key bindings with the ⌘ key.
" NOTE: in some cases, `key` is allowed to contain a modifier, but not `M-`
function! MapSuperKey(key, rhs, modes = "all", no_insert = v:false, remap = v:false, map_flag = '') abort
    let l:no_insert = a:no_insert
    if exists("g:gui_running")
        if has('nvim')
            let l:key = <SID>ShiftModifierIfNeededForSuper(a:key)
            let l:key .= l:key != '' ? tolower(a:key) : a:key
        else
            let l:key = a:key
        endif
        let l:keys = '<D-' . l:key . '>'
    else
        let l:keys = s:NormalizeMetaModifier('<M-' . a:key . '>')
        let l:no_insert = l:keys != '<M-' . a:key . '>' || l:no_insert
    endif
    call MapKey(l:keys, a:rhs, a:modes, l:no_insert, a:remap, a:map_flag)
endfunction

" Maps the Control (⌃) key, or in GUIs the fallback Option (⌥), key.
" 2022-10-30 That's because neither MacVim/VimR support modifyOtherKeys yet
"   and thus treat <C-S-A> like <C-A>.
" NOTE: in some cases, `key` is allowed to contain a modifier, but not `M-`
function! MapControlKey(key, rhs, modes = "all", no_insert = v:false, remap = v:false, map_flag = '') abort
    let l:no_insert = a:no_insert
    if exists("g:gui_running")
        let l:keys = s:NormalizeMetaModifier('<M-' . a:key . '>')
        let l:no_insert = l:keys != '<M-' . a:key . '>' || l:no_insert
    else
        let l:key = <SID>ShiftModifierIfNeededForControl(a:key)
        " XXX I think the tolower isn't needed here because case doesn't matter with <C->
        let l:key .= l:key != '' ? tolower(a:key) : a:key
        let l:keys = '<C-' . l:key . '>'
    endif
    call MapKey(l:keys, a:rhs, a:modes, l:no_insert, a:remap, a:map_flag)
endfunction

" Maps the Control (⌃) key in TUIs or the Command (⌘) key in GUIs.
" 2022-10-30 That's because neither MacVim/VimR support modifyOtherKeys yet
"   and thus treat <C-D-a> like <C-A>.
function! MapSuperOrControlKey(key, rhs, modes = "all", no_insert = v:false, remap = v:false, map_flag = '') abort
    if exists("g:gui_running")
        call MapKey('<D-' . <SID>ShiftModifierIfNeededForSuper(a:key) . tolower(a:key) . '>',
                    \ a:rhs, a:modes, a:no_insert, a:remap, a:map_flag)
    else
        call MapKey('<C-' . <SID>ShiftModifierIfNeededForControl(a:key) . a:key . '>',
                    \ a:rhs, a:modes, a:no_insert, a:remap, a:map_flag)
    endif
endfunction

