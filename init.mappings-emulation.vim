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
function! s:MapAlias(keys, rhs) abort
    let l:rhs = s:NormalizeMetaModifier(a:rhs)
    execute 'map'  a:keys l:rhs
    execute 'map!' a:keys l:rhs
    execute 'tmap' a:keys l:rhs
endfunction

" Maps the key sequence to RHS, optionally with specific modes
function! MapKey(keys, rhs, modes = "all", no_insert = 0, no_remap = 1) abort
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
            let l:no_insert = 1
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
            execute l:nore . 'map!' l:keys l:prefixes[0] . l:rhs
        endif
    else
        for mode in l:modes
            if a:no_insert == 0 || !s:IsInsertLikeMode(mode)
                execute mode l:keys s:RhsPrefixForMode(l:rhs, mode)
            endif
        endfor
    endif
endfunction

" Maps both the Option (⌥) and Command (⌘) versions for universal
" access and easy GUI access
function! s:NoremapSuperKey(key, rhs, ...) abort
    let l:modes = get(a:, 2, 'all')
    call MapKey('<M-' . a:key . '>', a:rhs, l:modes)
    if has("gui_running")
        call MapKey('<D-' . a:key . '>', a:rhs, l:modes)
    endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" macOS: make composed keys act like Meta {{{1

" TODO: to have macmeta working, I'd need to MapAlias a whole different
"   set of accented characters.

" NOTE: Won't remap –, —, ≠, ±, …  as these are useful special characters even to
"   Americans
" NOTE: Can't remap `, e, u, i, n as these are useful to compose digraph prefixes
call <SID>MapAlias('å', '<M-a>')
call <SID>MapAlias('Å', '<M-A>')
call <SID>MapAlias('∫', '<M-b>')
call <SID>MapAlias('ı', '<M-B>')
call <SID>MapAlias('ç', '<M-c>')
call <SID>MapAlias('Ç', '<M-C>')
call <SID>MapAlias('∂', '<M-d>')
call <SID>MapAlias('Î', '<M-D>')
call <SID>MapAlias('ƒ', '<M-f>')
call <SID>MapAlias('´', '<M-E>')
call <SID>MapAlias('Ï', '<M-F>')
call <SID>MapAlias('©', '<M-g>')
call <SID>MapAlias('˝', '<M-G>')
call <SID>MapAlias('˙', '<M-h>')
call <SID>MapAlias('Ó', '<M-H>')
call <SID>MapAlias('ˆ', '<M-I>')
call <SID>MapAlias('∆', '<M-j>')
call <SID>MapAlias('Ô', '<M-J>')
call <SID>MapAlias('˚', '<M-k>')
call <SID>MapAlias('', '<M-K>')
call <SID>MapAlias('¬', '<M-l>')
call <SID>MapAlias('Ò', '<M-L>')
call <SID>MapAlias('µ', '<M-m>')
call <SID>MapAlias('Â', '<M-M>')
call <SID>MapAlias('˜', '<M-N>')
call <SID>MapAlias('ø', '<M-o>')
call <SID>MapAlias('Ø', '<M-O>')
call <SID>MapAlias('π', '<M-p>')
call <SID>MapAlias('∏', '<M-P>')
call <SID>MapAlias('œ', '<M-q>')
call <SID>MapAlias('Œ', '<M-Q>')
call <SID>MapAlias('®', '<M-r>')
call <SID>MapAlias('‰', '<M-R>')
call <SID>MapAlias('ß', '<M-s>')
call <SID>MapAlias('Í', '<M-S>')
call <SID>MapAlias('†', '<M-t>')
call <SID>MapAlias('ˇ', '<M-T>')
call <SID>MapAlias('¨', '<M-U>')
call <SID>MapAlias('√', '<M-v>')
call <SID>MapAlias('◊', '<M-V>')
call <SID>MapAlias('∑', '<M-w>')
call <SID>MapAlias('„', '<M-W>')
call <SID>MapAlias('≈', '<M-x>')
call <SID>MapAlias('˛', '<M-X>')
call <SID>MapAlias('¥', '<M-y>')
call <SID>MapAlias('Á', '<M-Y>')
call <SID>MapAlias('Ω', '<M-z>')
call <SID>MapAlias('¸', '<M-Z>')
call <SID>MapAlias('¡', '<M-1>')
call <SID>MapAlias('⁄', '<M-!>')
call <SID>MapAlias('™', '<M-2>')
call <SID>MapAlias('€', '<M-@>')
call <SID>MapAlias('£', '<M-3>')
call <SID>MapAlias('‹', '<M-#>')
call <SID>MapAlias('¢', '<M-4>')
call <SID>MapAlias('›', '<M-$>')
call <SID>MapAlias('∞', '<M-5>')
call <SID>MapAlias('ﬁ', '<M-%>')
call <SID>MapAlias('§', '<M-6>')
call <SID>MapAlias('ﬂ', '<M-^>')
call <SID>MapAlias('¶', '<M-7>')
call <SID>MapAlias('‡', '<M-&>')
call <SID>MapAlias('•', '<M-8>')
call <SID>MapAlias('°', '<M-*>')
call <SID>MapAlias('ª', '<M-9>')
call <SID>MapAlias('·', '<M-(>')
call <SID>MapAlias('º', '<M-0>')
call <SID>MapAlias('‚', '<M-)>')
call <SID>MapAlias('“', '<M-[>')
call <SID>MapAlias('”', '<M-{>')
call <SID>MapAlias('‘', '<M-]>')
call <SID>MapAlias('’', '<M-}>')
call <SID>MapAlias('«', '<M-Bslash>')
call <SID>MapAlias('»', '<M-Bar>')
call <SID>MapAlias("æ", "<M-'>")
call <SID>MapAlias('Ú', '<M-:>')
call <SID>MapAlias('æ', "<M-'>")
call <SID>MapAlias('Æ', '<M-">')
call <SID>MapAlias('≤', '<M-,>')
call <SID>MapAlias('¯', '<M-lt>')
call <SID>MapAlias('≥', '<M-.>')
call <SID>MapAlias('˘', '<M->>')
call <SID>MapAlias('¿', '<M-?>')
call <SID>MapAlias('÷', '<M-/>')

call <SID>MapAlias('<D-”>', '<M-S-D-{>')
call <SID>MapAlias('<D-’>', '<M-S-D-}>')
call <SID>MapAlias('<D-±>', '<M-S-D-BS>')

" In vim within iTerm, Opt+F12 is <Esc>[24~
call <SID>MapAlias('<Esc>[24~', '<M-F12>')
if has("nvim")
    call <SID>MapAlias('<F60>', '<M-F12>')
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PuTTY for Windows

" NOTE: don't remap insert mode as they slow down the switch to Normal
" mode, which often interferes with my ability to then quickly hit `Cmd+s` in
" to save in vim GUIs.
" This isn't a problem withVisual mode because there's already a delay no
" matter what.
nmap <Esc>OA <Up>
nmap <Esc>OB <Down>
nmap <ESC>[Z <S-Tab>
vmap <Esc>OA <Up>
vmap <Esc>OB <Down>
vmap <ESC>[Z <S-Tab>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate neovim {{{1"}}}

if has("nvim")
    " Can't remap `Y` as it's used incredibly often and needs to be pressed reliably
    silent! nunmap Y
endif
" Clear search highlight, update diff, and redraw screen
nnoremap <C-l> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>
" Allow <C-u> and <C-w> to be undone
inoremap <C-u> <C-g>u<C-U>
inoremap <C-w> <C-g>u<C-W>
" Make `*` and `#` work on visual selection. NOTE: overridden by visual-star-search
xnoremap * y/\V<C-r>"<CR>
xnoremap # y?\V<C-r>"<CR>
" Repeat last substitute with all the same flags
nnoremap & :&&<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate Emacs {{{1
" Also to replace the useless and dangerous ^A and ^X in normal mode,
" starting to use ^X as a leader in normal mode, just like in emacs and vim
" insert mode.

""" File operations

nnoremap <C-x><C-s> <Cmd>w<CR>
nnoremap <C-x><C-f> <Cmd>e
inoremap <C-x><C-s> <Cmd>w<CR>
nnoremap <C-a> 0

""" Window operations

nnoremap <C-x>2 <C-w>s
nnoremap <C-x>3 <C-w>v
nnoremap <C-x>0 <C-w>c
nnoremap <C-x>1 <C-w>o
nnoremap <C-x>o <C-w>w
nnoremap <C-x>+ <C-w>=

""" Command-line

cnoremap <C-g> <C-c>

""" Formatting

" Emulate emacs, saving the cursor position
nnoremap <Esc>q m`gqip``
" FIXME: can't get this to work -- cursor position is wrong at end of line
"inoremap <Esc>q <C-o>m`<C-o>gqip<C-o>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate misc apps {{{1

" `less`: Remove search highlight (NOTE: neovim's `<C-l>` is better)
nnoremap <Esc>u <Cmd>noh<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate common GUI apps {{{1

""" General

" Open recent
call <SID>NoremapSuperKey('p', '<Cmd>GFiles --cached --others --exclude-standard<CR>')
call <SID>NoremapSuperKey('e', '<Cmd>CtrlPBuffer<CR>')
call <SID>NoremapSuperKey('E', '<Cmd>CtrlPBuffer<CR>')
call <SID>NoremapSuperKey('F', '<Cmd>RG<CR>')
call <SID>NoremapSuperKey('o', '<Cmd>Startify<CR>')
if has("gui_running")
    if has("gui_macvim")
        " In GUI: <M-D-o>
        call <SID>NoremapSuperKey('ø', '<Cmd>Startify<CR>')
    elseif has("gui_vimr")
        " In GUI: <M-D-o>
        call MapKey('<M-D-o>', '<Cmd>Startify<CR>')
    endif
endif

""" System clipboard

vnoremap <M-x> "+d
vnoremap <M-c> "+y
vnoremap <M-v> "+gP
nnoremap <M-v> "+gP
cnoremap <M-v> <C-R>+
inoremap <M-v> <C-R><C-O>+

""" Movement {{{2

" Wrapped line navigation
call MapKey('<Up>', 'gk')
call MapKey('<Down>', 'gj')
call MapKey('<M-z>', '<Cmd>set wrap!<CR>')

" Move cursor
call MapKey('<D-Up>', 'gg')
call MapKey('<D-Down>', 'G')
call MapKey('<D-Left>', '0')
call MapKey('<D-Right>', '$')

" Go back/forward
call MapKey('<M-D-Left>', '<C-o>')
call MapKey('<M-D-Right>', '<C-i>')

" Go to previous edit location
call MapKey('<S-D-BS>', '`.')
" Delete line
call MapKey('<C-S-BS>', 'dd')
call MapKey('<D-Del>', 'D')
call MapKey('<D-BS>', 'd0')

" Go to previous/next git change
call MapKey('<C-S-Up>', '[c', 'all', 0, 0)
call MapKey('<C-S-Down>', ']c', 'all', 0, 0)

" Go to previous/next method
call MapKey('<C-S-D-Up>', '[m')
call MapKey('<C-S-D-Down>', ']m')

""" Indent {{{2

" XXX: can't remap normal-mode <Tab> as that's the same as <C-i>
"nnoremap <Tab> >>
nnoremap <S-Tab> <<
nnoremap <D-]> >>
inoremap <D-]> <C-t>
nnoremap <D-[> <<
inoremap <D-[> <C-d>
" Need to reselect selection
vnoremap <Tab> >gv
vnoremap <D-]> >gv
vnoremap <S-Tab> <gv
vnoremap <D-[> <gv

""" Line manipulation {{{2

" Insert empty line above/below
call MapKey('<C-CR>', 'o')
call MapKey('<S-C-CR>', 'O')

" Shift argument (using vim-argumentative)
call MapKey('<M-lt>', '<,', 'all', 0, 0)
call MapKey('<M->>', '>,', 'all', 0, 0)

""" Splits {{{2

call MapKey('<M-R>', '<Cmd>vsplit<CR>')
call MapKey('<M-S>', '<Cmd>split<CR>')
call MapKey('<M-W>', '<C-w>c')
call MapKey('<M-O>', '<C-w>o')
call MapKey('<M-H>', '<C-w>h')
call MapKey('<M-J>', '<C-w>j')
call MapKey('<M-K>', '<C-w>k')
call MapKey('<M-L>', '<C-w>l')
call MapKey('<M-S-D-+>', '<C-w>=')

" Toggle split orientation
" https://stackoverflow.com/questions/1269603/to-switch-from-vertical-split-to-horizontal-split-fast-in-vim/45994525#45994525
function! ToggleSplitOrientation()
    if !exists('t:splitType')
        let t:splitType = 'vertical'
    endif
    if t:splitType == 'vertical'
        windo wincmd K
        let t:splitType = 'horizontal'
    else
        windo wincmd H
        let t:splitType = 'vertical'
    endif
endfunction
nnoremap <silent> <C-w><Bslash> <Cmd>call ToggleSplitOrientation()<CR>
nnoremap <silent> <C-\> <Cmd>call ToggleSplitOrientation()<CR>

""" Tabs {{{2

call <SID>NoremapSuperKey('t', '<Cmd>tabnew<CR>')
call <SID>NoremapSuperKey('w', '<Cmd>tabclose<CR>')
call <SID>NoremapSuperKey('1', '<Cmd>tabn 1<CR>')
call <SID>NoremapSuperKey('2', '<Cmd>tabn 2<CR>')
call <SID>NoremapSuperKey('3', '<Cmd>tabn 3<CR>')
call <SID>NoremapSuperKey('4', '<Cmd>tabn 4<CR>')
call <SID>NoremapSuperKey('5', '<Cmd>tabn 5<CR>')
call <SID>NoremapSuperKey('6', '<Cmd>tabn 6<CR>')
call <SID>NoremapSuperKey('7', '<Cmd>tabn 7<CR>')
call <SID>NoremapSuperKey('8', '<Cmd>tabn 8<CR>')
call <SID>NoremapSuperKey('9', '<Cmd>tablast<CR>')
call <SID>NoremapSuperKey('{', '<Cmd>tabprev<CR>')
call <SID>NoremapSuperKey('}', '<Cmd>tabnext<CR>')

if has("gui_running")
    " Switch tab with ⌘+[1-9].
    call MapKey('<S-D-{>', '<Cmd>tabprev<CR>')
    call MapKey('<S-D-}>', '<Cmd>tabnext<CR>')

    " These don't work inside iTerm as they are passed as `<M-{>`
    call MapKey('<M-S-D-{>', '<Cmd>-tabmove<CR>')
    call MapKey('<M-S-D-}>', '<Cmd>+tabmove<CR>')
endif

" vim:foldmethod=marker:
