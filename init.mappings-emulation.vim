""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" macOS: make composed keys act like Meta {{{1

" TODO: to have macmeta working, I'd need to MapAlias a whole different
"   set of accented characters.

" NOTE: Won't remap –, —, ≠, ±, …  as these are useful special characters even to
"   Americans
" NOTE: Can't remap `, e, u, i, n as these are useful to compose digraph prefixes
call MapAlias('å', '<M-a>')
call MapAlias('Å', '<M-A>')
call MapAlias('∫', '<M-b>')
call MapAlias('ı', '<M-B>')
call MapAlias('ç', '<M-c>')
call MapAlias('Ç', '<M-C>')
call MapAlias('∂', '<M-d>')
call MapAlias('Î', '<M-D>')
call MapAlias('ƒ', '<M-f>')
call MapAlias('´', '<M-E>')
call MapAlias('Ï', '<M-F>')
call MapAlias('©', '<M-g>')
call MapAlias('˝', '<M-G>')
call MapAlias('˙', '<M-h>')
call MapAlias('Ó', '<M-H>')
call MapAlias('ˆ', '<M-I>')
call MapAlias('∆', '<M-j>')
call MapAlias('Ô', '<M-J>')
call MapAlias('˚', '<M-k>')
call MapAlias('', '<M-K>')
call MapAlias('¬', '<M-l>')
call MapAlias('Ò', '<M-L>')
call MapAlias('µ', '<M-m>')
call MapAlias('Â', '<M-M>')
call MapAlias('˜', '<M-N>')
call MapAlias('ø', '<M-o>')
call MapAlias('Ø', '<M-O>')
call MapAlias('π', '<M-p>')
call MapAlias('∏', '<M-P>')
call MapAlias('œ', '<M-q>')
call MapAlias('Œ', '<M-Q>')
call MapAlias('®', '<M-r>')
call MapAlias('‰', '<M-R>')
call MapAlias('ß', '<M-s>')
call MapAlias('Í', '<M-S>')
call MapAlias('†', '<M-t>')
call MapAlias('ˇ', '<M-T>')
call MapAlias('¨', '<M-U>')
call MapAlias('√', '<M-v>')
call MapAlias('◊', '<M-V>')
call MapAlias('∑', '<M-w>')
call MapAlias('„', '<M-W>')
call MapAlias('≈', '<M-x>')
call MapAlias('˛', '<M-X>')
call MapAlias('¥', '<M-y>')
call MapAlias('Á', '<M-Y>')
call MapAlias('Ω', '<M-z>')
call MapAlias('¸', '<M-Z>')
call MapAlias('¡', '<M-1>')
call MapAlias('⁄', '<M-!>')
call MapAlias('™', '<M-2>')
call MapAlias('€', '<M-@>')
call MapAlias('£', '<M-3>')
call MapAlias('‹', '<M-#>')
call MapAlias('¢', '<M-4>')
call MapAlias('›', '<M-$>')
call MapAlias('∞', '<M-5>')
call MapAlias('ﬁ', '<M-%>')
call MapAlias('§', '<M-6>')
call MapAlias('ﬂ', '<M-^>')
call MapAlias('¶', '<M-7>')
call MapAlias('‡', '<M-&>')
call MapAlias('•', '<M-8>')
call MapAlias('°', '<M-*>')
call MapAlias('ª', '<M-9>')
call MapAlias('·', '<M-(>')
call MapAlias('º', '<M-0>')
call MapAlias('‚', '<M-)>')
call MapAlias('“', '<M-[>')
call MapAlias('”', '<M-{>')
call MapAlias('‘', '<M-]>')
call MapAlias('’', '<M-}>')
call MapAlias('«', '<M-Bslash>')
call MapAlias('»', '<M-Bar>')
call MapAlias("æ", "<M-'>")
call MapAlias('Ú', '<M-:>')
call MapAlias('æ', "<M-'>")
call MapAlias('Æ', '<M-">')
call MapAlias('≤', '<M-,>')
call MapAlias('¯', '<M-lt>')
call MapAlias('≥', '<M-.>')
call MapAlias('˘', '<M->>')
call MapAlias('¿', '<M-?>')
call MapAlias('÷', '<M-/>')

call MapAlias('<D-”>', '<M-S-D-{>')
call MapAlias('<D-’>', '<M-S-D-}>')
call MapAlias('<D-±>', '<M-S-D-BS>')

" In vim within iTerm, Opt+F12 is <Esc>[24~
call MapAlias('<Esc>[24~', '<M-F12>')
if has("nvim")
    call MapAlias('<F60>', '<M-F12>')
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

nnoremap <C-x><C-f> :e<Space>
" NOTE: <C-x><C-s> is overridden elsewhere to reload .vimrc
nnoremap <C-x><C-s> <Cmd>w<CR>
inoremap <C-x><C-s> <Cmd>w<CR>

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
call NoremapSuperKey('p', '<Cmd>GFiles --cached --others --exclude-standard<CR>')
call NoremapSuperKey('e', '<Cmd>CtrlPBuffer<CR>')
call NoremapSuperKey('E', '<Cmd>CtrlPBuffer<CR>')
" We don't remap `<M-S-F>` because we use that as alternate for `<C-S-F>` needed in MacVim/VimR
call MapKey('<S-D-F>', '<Cmd>RG<CR>')
call NoremapSuperKey('o', '<Cmd>Startify<CR>')
if has("gui_running")
    if has("gui_macvim")
        " In GUI: <M-D-o>
        call NoremapSuperKey('ø', '<Cmd>Startify<CR>')
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

" We prefer using `<M>` instead of `<C>` here because:
" 1) these won't conflict with iTerm's split keybindings
" 2) MacVim/VimR don't support modifyOtherKeys as of 2022-10-28
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

" NOTE: we avoid <C-2> and <C-6> because these are ANSI control characters
"   (even Shift isn't pressed)
call NoremapSuperKey('t', '<Cmd>tabnew<CR>')
call NoremapSuperKey('w', '<Cmd>tabclose<CR>')
call NoremapSuperKey('1', '<Cmd>tabn 1<CR>')
call NoremapSuperKey('2', '<Cmd>tabn 2<CR>')
call NoremapSuperKey('3', '<Cmd>tabn 3<CR>')
call NoremapSuperKey('4', '<Cmd>tabn 4<CR>')
call NoremapSuperKey('5', '<Cmd>tabn 5<CR>')
call NoremapSuperKey('6', '<Cmd>tabn 6<CR>')
call NoremapSuperKey('7', '<Cmd>tabn 7<CR>')
call NoremapSuperKey('8', '<Cmd>tabn 8<CR>')
call NoremapSuperKey('9', '<Cmd>tablast<CR>')
call NoremapSuperKey('{', '<Cmd>tabprev<CR>')
call NoremapSuperKey('}', '<Cmd>tabnext<CR>')

if has("gui_running")
    call MapKey('<S-D-{>', '<Cmd>tabprev<CR>')
    call MapKey('<S-D-}>', '<Cmd>tabnext<CR>')

    " These don't work inside iTerm as they are passed as `<M-{>`
    call MapKey('<M-S-D-{>', '<Cmd>-tabmove<CR>')
    call MapKey('<M-S-D-}>', '<Cmd>+tabmove<CR>')
endif

""" Terminal

call MapKey('<M-F12>', '<Cmd>call OpenTerminal()<CR>')
call MapKey('<C-S-Z>', '<Cmd>call RevealInTerminal()<CR>')
" We need alternate for MacVim/VimR
call MapKey('<M-Z>', '<Cmd>call RevealInTerminal()<CR>')

call MapKey('<C-S-T>', '<Cmd>!iterm2-new-tab-with-path %:p:h<CR>')
" We need alternate for MacVim/VimR
call MapKey('<M-T>', '<Cmd>!iterm2-new-tab-with-path %:p:h<CR>')

""" External Apps

call MapKey('<C-S-F>', '<Cmd>Reveal<CR>')
" We need alternate for MacVim/VimR
call MapKey('<M-F>', '<Cmd>Reveal<CR>')

call MapKey('<C-S-C>', '<Cmd>CodeCurrent<CR>')
" We need alternate for MacVim/VimR
call MapKey('<M-C>', '<Cmd>CodeCurrent<CR>')

" vim:foldmethod=marker:
