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

" TODO: automate these MapAlias whenever it's used
call MapAlias('µµ', '<M-m><M-m>')
call MapAlias('µπ', '<M-m><M-p>')
"call MapAlias('µ¬', '<M-m><M-l>')

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
if has('nvim')
    call MapSuperKey('p', '<F4>', 'all', v:false, v:false)
else
    call MapSuperKey('p', '<Cmd>GFiles --cached --others --exclude-standard<CR>')
endif
call MapSuperKey('e', '<F2>', 'all', v:false, v:false)
call MapSuperKey('E', '<F2>', 'all', v:false, v:false)
call MapSuperKey('F', '<F3>', 'all', v:false, v:false)
call MapSuperKey('"', '<F10>', 'all', v:false, v:false)

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
call MapKey('<M-t>w', '<Cmd>set wrap!<CR>')

" Move cursor
call MapKey('<D-Up>', 'gg')
call MapKey('<D-Down>', 'G')
call MapKey('<D-Left>', '0')
call MapKey('<D-Right>', '$')

" Go back/forward
call MapKey('<M-C-Left>', '<Plug>CamelCaseMotion_b')
call MapKey('<M-C-Right>', '<Plug>CamelCaseMotion_w')
" XXX These don't work in terminal:
call MapKey('<M-D-Left>', '<C-O>')
call MapKey('<M-D-Right>', '<C-I>')

" Go to previous edit location
call MapSuperKey('S-BS', 'g;')
call MapSuperOrControlKey('M-S-BS', 'g,')
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

call MapControlKey('R', '<Cmd>vsplit<CR>')
call MapControlKey('S', '<Cmd>split<CR>')
call MapControlKey('W', '<C-w>c')
call MapControlKey('O', '<C-w>o')
call MapControlKey('H', '<C-w>h')
call MapControlKey('J', '<C-w>j')
call MapControlKey('K', '<C-w>k')
call MapControlKey('L', '<C-w>l')
if has('gui_running') && has('nvim')
    call MapKey('<M-S-D-+>', '<C-w>=')
elseif has('gui_running') && !has('nvim')
    call MapKey('<D-±>', '<C-w>=')
elseif has('nvim')
    call MapKey('<M-C-+>', '<C-w>=')
else
    " NOTE: Can't get it to work in vim in iTerm
    " call MapKey('«', '<C-w>=')
    " call MapKey('<S-«>', '<C-w>=')
endif
call MapSuperOrControlKey('M-S-Left', '<C-w>H')
call MapSuperOrControlKey('M-S-Down', '<C-w>J')
call MapSuperOrControlKey('M-S-Up', '<C-w>K')
call MapSuperOrControlKey('M-S-Right', '<C-w>L')

" TODO: should we make MapSuperOrControlKey handle the weird case of Bar and BSlash
" For imap, we'd need to have <C-o> twice
if has('gui_running') && has('nvim')
    call MapKey('<M-S-D-Bar>', '<C-w>_<C-w><Bar>', ['nmap'])
elseif has('gui_running') && !has('nvim')
    call MapKey('<D-»>', '<C-w>_<C-w><Bar>', ['nmap'])
elseif has('nvim')
    call MapKey('<M-C-Bslash>', '<C-w>_<C-w><Bar>', ['nmap'])
else
    " NOTE: Can't get it to work in vim in iTerm
    " call MapKey('ü', '<C-w>_<C-w><Bar>', ['nmap'])
    " call MapKey('<S-ü>', '<C-w>_<C-w><Bar>', ['nmap'])
endif

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
" NOTE: For terminal, we need to use <C-Bslash> because <C-S-Bar> is not possible since <C-\> is
" an ANSI control sequence
call MapKey('<C-Bslash>', '<Cmd>call ToggleSplitOrientation()<CR>')

""" Tabs {{{2

" NOTE: we avoid <C-2> and <C-6> because these are ANSI control characters
"   (even Shift isn't pressed)
call MapSuperKey('t', '<Cmd>tabnew<CR>')
" NOTE: ⌥W closes a tab because GUI's ⌘W (and our ⌃⇧W) closes a split
call MapKey('<M-w>', '<Cmd>tabclose<CR>')
call MapSuperKey('1', '<Cmd>tabn 1<CR>')
call MapSuperKey('2', '<Cmd>tabn 2<CR>')
call MapSuperKey('3', '<Cmd>tabn 3<CR>')
call MapSuperKey('4', '<Cmd>tabn 4<CR>')
call MapSuperKey('5', '<Cmd>tabn 5<CR>')
call MapSuperKey('6', '<Cmd>tabn 6<CR>')
call MapSuperKey('7', '<Cmd>tabn 7<CR>')
call MapSuperKey('8', '<Cmd>tabn 8<CR>')
call MapSuperKey('9', '<Cmd>tablast<CR>')
call MapSuperKey('{', '<Cmd>tabprev<CR>')
call MapSuperKey('}', '<Cmd>tabnext<CR>')

call MapControlKey('{', '<Cmd>-tabmove<CR>')
call MapControlKey('}', '<Cmd>+tabmove<CR>')

""" Code editing

" titlecase
" NOTE: These also work in operator-pending
call MapKey('<M-c>T', 'viW<Plug>Titlecase<CR>', ['nmap'])
call MapKey('<M-c>t', '<Plug>Titlecase', ['map'])
call MapKey('<M-c>tt', '<Plug>TitlecaseLine', ['nmap'])

" camelsnek
" NOTE: These don't work in operator-pending mode
call MapKey('<M-c>C', ':CamelB<CR>', ['map'])
call MapKey('<M-c>K', ':Kebab<CR>', ['map'])
" Zcp: PascalCase, a.k.a. MixedCase
call MapKey('<M-c>P', ':Camel<CR>', ['map'])
call MapKey('<M-c>S', ':Snek<CR>', ['map'])
call MapKey('<M-c>_', ':Screm<CR>', ['map'])

" abolish
" NOTE: These don't work in operator-pending mode or visual mode
call MapKey('<M-c>D', 'cr.', ['map'])

""" Code navigation

call MapSuperKey('b', 'gd')

""" Markdown

call MapKey('<M-m><M-m>', '<Cmd>MarkdownPreview<CR>')
call MapKey('<M-m><M-p>', '<Cmd>Glow<CR>')
call MapKey('<M-m><M-p>', '<Cmd>Glow<CR>')

""" Colors

call MapKey('<M-t>b', '<Cmd>call ToggleBackground()<CR>')
call MapKey('<M-t>c', '<Cmd>HexokinaseToggle<CR>')

""" Terminal

call MapKey('<M-F12>', '<Cmd>call OpenTerminal()<CR>')
call MapControlKey('Z', '<Cmd>call RevealInTerminal()<CR>')

call MapControlKey('T', '<Cmd>!iterm2-new-tab-with-path %:p:h<CR>')

""" Internal Apps

if has('nvim')
  call MapControlKey('E', '<Cmd>NvimTreeFindFile<CR>')
else
  call MapControlKey('E', '<Cmd>NERDTreeFind<CR>')
endif


""" External Apps

call MapControlKey('F', '<Cmd>Reveal<CR>')
call MapControlKey('C', '<Cmd>CodeCurrent<CR>')

" vim:foldmethod=marker:
