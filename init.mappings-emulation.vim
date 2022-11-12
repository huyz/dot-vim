""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate neovim {{{1

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

nnoremap <C-x>b :b<Space>
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate misc apps {{{1

" `less`: Remove search highlight (NOTE: neovim's `<C-l>` is better)
nnoremap <Esc>u <Cmd>noh<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate common GUI apps {{{1

""" General

" Open recent
if exists('g:gui_running')
    if has('nvim')
        call MapSuperKey('p', '<C-F4>', 'all', v:false, v:true)
    else
        call MapSuperKey('p', '<Cmd>GFiles --cached --others --exclude-standard<CR>')
    endif
endif
" We actually need to map ⇧⌥P in terminals so as to not conflict with our ⌥P chord prefix,
" and BetterTouchTool can handle the detour
if has('nvim')
    call MapSuperKey('P', '<C-F4>', 'all', v:false, v:true)
else
    call MapSuperKey('P', '<Cmd>GFiles --cached --others --exclude-standard<CR>')
endif

call MapSuperKey('e', '<C-F2>', 'all', v:false, v:true)
call MapSuperKey('E', '<C-F2>', 'all', v:false, v:true)
call MapSuperKey('F', '<C-F3>', 'all', v:false, v:true)
call MapSuperKey('"', '<C-F10>', 'all', v:false, v:true)

""" System clipboard

" GUI apps should already have the ⌘ versions mapped
if !has('gui_running')
    vnoremap <M-x> "+d
    vnoremap <M-c> "+y
    vnoremap <M-v> "+gP
    nnoremap <M-v> "+gP
    cnoremap <M-v> <C-R>+
    inoremap <M-v> <C-R><C-O>+
endif

""" Movement {{{2

" Wrapped line navigation
call MapKey('<Up>', 'gk')
call MapKey('<Down>', 'gj')
call MapKey('<M-t>w', '<Cmd>set wrap!<CR>')

" Move cursor
call MapSuperKey('Up', 'gg')
call MapSuperKey('Down', 'G')
call MapSuperKey('Left', '0')
call MapSuperKey('Right', '$')

" Go back/forward and/or CamelCaseMotion
" NOTE: Luckily, iTerm passes <M-D-arrows> through
call MapKey('<M-D-Left>', '<C-O>')
call MapKey('<M-D-Right>', '<C-I>')
call MapKey('<M-C-Left>', '<Plug>CamelCaseMotion_b')
call MapKey('<M-C-Right>', '<Plug>CamelCaseMotion_w')

" Go to previous edit location and Delete parts of line
call MapSuperKey('S-BS', 'g;')
call MapSuperOrControlKey('M-S-BS', 'g,')
                        call MapSuperKey('Del', 'D')
call MapSuperKey('BS', 'd0')

" Go to previous/next git change
call MapKey('<C-S-Up>', '[c', 'all', 0, 0)
call MapKey('<C-S-Down>', ']c', 'all', 0, 0)

" Go to previous/next method
if exists('g:gui_running')
    call MapKey('<C-S-D-Up>', '[m')
    call MapKey('<C-S-D-Down>', ']m')
else
    call MapKey('<C-S-M-Up>', '[m')
    call MapKey('<C-S-M-Down>', ']m')
endif

""" Indent {{{2

" Need to reselect selection
if exists('g:gui_running')
    nnoremap <D-]> >>
    nnoremap <D-[> <<
    noremap! <D-]> <C-t>
    noremap! <D-[> <C-d>
    vnoremap <D-]> >gv
    vnoremap <D-[> <gv
else
    " NOTE: can't use `MapKey` because it doesn't handle `<M-[>;` shouldn't
    "   normalize to `<Esc>[` which is the prefix of escape sequences
    nnoremap <M-]> >>
    nnoremap <M-[> <<
    noremap! <M-]> <C-t>
    noremap! <M-[> <C-d>
    vnoremap <M-]> >gv
    vnoremap <M-[> <gv
endif

""" Line manipulation {{{2

" Insert empty line above/below
call MapKey('<C-CR>', 'o')
call MapKey('<S-C-CR>', 'O')

" Delete lines
call MapKey('<C-S-BS>', 'dd')

" Shift argument (using vim-argumentative)
call MapKey('<M-lt>', '<,', 'all', v:false, v:true)
call MapKey('<M->>', '>,', 'all', v:false, v:true)

""" Splits {{{2

call MapControlKey('R', '<Cmd>vsplit<CR>')
call MapControlKey('S', '<Cmd>split<CR>')
" Make that equivalent to MacVim/VimR's ⌘W
call MapKey('<M-w>', '<Cmd>close<CR>')

" Focus split
call MapControlKey('W', '<C-w>c')
call MapControlKey('O', '<C-w>o')
call MapControlKey('H', '<C-w>h')
call MapControlKey('J', '<C-w>j')
call MapControlKey('K', '<C-w>k')
call MapControlKey('L', '<C-w>l')
call MapKey('<M-z>', '<C-w>W')
call MapKey('<M-Z>', '<C-w>w')

" Move splits
call MapSuperOrControlKey('M-S-Left', '<C-w>H')
call MapSuperOrControlKey('M-S-Right', '<C-w>L')
" NOTE: we don't do MapSuperOrControlKey for up and down because they conflict
"   in the terminal with previous/next member
call MapSuperKey('M-S-Up', '<C-w>K')
call MapSuperKey('M-S-Down', '<C-w>J')

" Equalize splits
call MapSuperOrControlKey('M-+', '<C-w>=')

" Maximize split
if exists('g:gui_running')
    let s:key = '<M-S-D-Bar>'
else
    " FIXME: can't get vim in terminal to work
    let s:key = '<M-C-Bar>'
endif
call MapKey(s:key, '<C-w>_<C-w><Bar>', ['nmap'])
call MapKey(s:key, '<C-o><C-w>_<C-o><C-w><Bar>', ['map!'])
call MapKey(s:key, '<C-\><C-N><C-w>_<C-\><C-N><C-w><Bar>', ['tmap'])

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
call MapKey('<C-Bslash>', '<Cmd>call ToggleSplitOrientation()<CR>', 'all', v:true)

""" Tabs {{{2

" NOTE: we avoid <C-2> and <C-6> because these are ANSI control characters
"   (even Shift isn't pressed
call MapSuperKey('t', '<Cmd>tabnew<CR>')
" NOTE: ⌥⌘W closes a tab because GUI's ⌘W (and our ⇧W) closes a split (like in iTerm)
call MapSuperOrControlKey('M-w', '<Cmd>tabclose<CR>')
" MacVim and VimR steal the ⌥⌘W mapping and don't offer a way to reset it, so we need
" an alternate that BetterTouchTool can route through
if exists('g:gui_running')
    call MapKey('<M-S-D-w>', '<Cmd>tabclose<CR>')
endif
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

" NOTE: as of 2022-11-02, `<Cmd>TComment*` doesn't work with ranges
call MapSuperKey('/', ':TComment<CR>')
call MapSuperOrControlKey('M-/', ':TCommentInline<CR>')

" titlecase
" NOTE: These also work in operator-pending
call MapKey('<M-c>T', 'viW<Plug>Titlecase', ['nmap'])
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

call MapKey('<F1>' , 'K', 'all', v:false, v:true)
call MapSuperKey('b', 'gd', 'all', v:false, v:true)
call MapSuperKey('B', 'gy', 'all', v:false, v:true)
call MapSuperOrControlKey('M-b', 'gi', 'all', v:false, v:true)
call MapSuperKey('y', '<Cmd>vsplit<CR>gd', 'all', v:false, v:true)
call MapSuperKey('Y', '<Cmd>vsplit<CR>gy', 'all', v:false, v:true)
call MapSuperKey('i', 'gR', 'all', v:false, v:true)

""" Markdown

call MapKey('<M-m>p', '<Cmd>MarkdownPreview<CR>')
call MapKey('<M-m><M-p>', '<Cmd>Glow<CR>')
call MapKey('<M-m><M-p>', '<Cmd>Glow<CR>')

" Tip: for entire lines, don't use `V`; use `val` from textobj-line to avoid spurious newlines
call MapSuperKey('C', 'ysiW`', ['nmap'], v:false, v:true)
call MapSuperKey('C', 'S`', ['vmap'], v:false, v:true)

function! s:MapMarkdown() abort
    " NOTE: to get this to work in iTerm, I hvae to use ⌃ key instead of ⌘, but because
    "   I personally reserve <C-S-M-letter> to launch apps (with BetterTouchTool),
    "   I have to rely on BetterTouchTool to map <M-S-D-C> to <M-C-S-C> as intermediary
    call MapSuperOrControlKey('M-C', 'O```<Esc>Yjp', ['nmap'], v:false, v:false,  '<buffer>')
    call MapSuperOrControlKey('M-C', '<Esc>`<lt>O```<Esc>yy`>pgv', ['vmap'], v:false, v:false, '<buffer>')

    " XXX: this markdown plugin doesn't work right:
    " call MapSuperKey('b',   '<Cmd>ruby Markdown::toggle_strong_at_cursor<CR>',    ['nmap'], v:false, v:true, '<buffer>')
    call MapSuperKey('b',   'mAysiW*.`All',    ['nmap'], v:false, v:true, '<buffer>')
    call MapSuperKey('b',   'S*gvS*gv<Esc>hh', ["vmap"], v:false, v:true, '<buffer>')
    " call MapSuperKey('i',   '<Cmd>ruby Markdown::toggle_emphasis_at_cursor<CR>',      ['nmap'], v:false, v:true, '<buffer>')
    call MapSuperKey('i',   'mAysiW_`Al',      ['nmap'], v:false, v:true, '<buffer>')
    call MapSuperKey('i',   'S_gv<Esc>h',      ["vmap"], v:false, v:true, '<buffer>')
    call MapSuperKey('X',   'mAysiW~.`All',    ['nmap'], v:false, v:true, '<buffer>')
    call MapSuperKey('X',   'S~gvS~gv<Esc>hh', ["vmap"], v:false, v:true, '<buffer>')
    call MapSuperKey('D',   'mAysiW=.`All',    ['nmap'], v:false, v:true, '<buffer>')
    call MapSuperKey('D',   'S=gvS=gv<Esc>hh', ["vmap"], v:false, v:true, '<buffer>')
endfunction
autocmd FileType markdown call <SID>MapMarkdown()

""" Markdown table mode

call MapKey('<M-T>t', '<Leader>tm', 'all', v:false, v:true)
call MapKey('<M-T>f', '<Leader>tm', 'all', v:false, v:true)
call MapKey('<M-T>i', '<Leader>tiC', 'all', v:false, v:true)
call MapKey('<M-T>a', '<Leader>tic', 'all', v:false, v:true)
call MapKey('<M-T>x', '<Leader>tdc', 'all', v:false, v:true)
call MapKey('<M-T>d', '<Leader>tdd', 'all', v:false, v:true)

""" Colors

call MapKey('<M-t>b', '<Cmd>call ToggleBackground()<CR>')
call MapKey('<M-t>c', '<Cmd>call ToggleColorscheme()<CR>')
call MapKey('<M-t>C', '<Cmd>HexokinaseToggle<CR>')

""" Terminal

call MapKey('<M-F12>', '<Cmd>call OpenTerminal()<CR>')
if has('nvim')
    call MapKey('<M-o>t', ':<C-u>call RevealInTerminal()<CR>')
else
    call MapKey('<M-o>t',
                \ '<Cmd>let $_term_dir = expand("%:p:h")<CR>' .
                \ '<Cmd>call RevealInTerminal()<CR>' .
                \ 'cd $_term_dir; unset _term_dir<CR>')
endif

" XXX Don't know why <M-o><M-t> doesn't work.
call MapKey('<M-o>T', '<Cmd>!iterm2-new-tab-with-path %:p:h<CR>')

""" Internal Apps

if has('nvim')
    call MapControlKey('E', '<Cmd>NvimTreeFindFile<CR>')
else
    call MapControlKey('E', '<Cmd>NERDTreeFind<CR>')
endif
imap <M-c>: <C-x><C-u>

""" External Apps

if has('mac')
    call MapKey('<M-s>d', '<Plug>DashSearch')
    call MapKey('<M-s>D', '<Plug>DashGlobalSearch')
endif
call MapKey('<M-s>g', '<Plug>SearchNormal', ['map'])
call MapKey('<M-s>g', '<Plug>SearchVisual', ['vmap'])
" NOTE: for some reason `<Cmd>` doesn't work right in visual mode, so use `:`
"   https://github.com/voldikss/vim-browser-search/issues/28
call MapKey('<M-s><M-s>', ':BrowserSearch<CR>')

call MapKey('<M-o>f', '<Cmd>Reveal<CR>')
call MapKey('<M-o>c', '<Cmd>CodeCurrent<CR>')

" vim:foldmethod=marker:
