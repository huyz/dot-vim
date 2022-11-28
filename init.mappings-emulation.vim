""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate neovim {{{1

if exists('g:nvim')
    " Don't allow neovim to remap `Y` as it's used incredibly often and needs to be pressed
    " reliably
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

" Disabled because we don't use emacs and these slow down normal-mode <C-x>
" nnoremap <C-x>b :b<Space>
" nnoremap <C-x><C-f> :e<Space>
" nnoremap <C-x><C-s> <Cmd>w<CR>
" inoremap <C-x><C-s> <Cmd>w<CR>

""" Window operations

" Disabled because we don't use emacs and these slow down normal-mode <C-x>
" nnoremap <C-x>2 <C-w>s
" nnoremap <C-x>3 <C-w>v
" nnoremap <C-x>0 <C-w>c
" nnoremap <C-x>1 <C-w>o
" nnoremap <C-x>o <C-w>w
" nnoremap <C-x>+ <C-w>=

" Since vim steals <C-k>, we'll make <C-k><C-k> work like it
inoremap <C-k><C-k> <C-o>DA

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate Apple HIG {{{1

" Based on /Applications/MacVim.app/Contents/Resources/vim/gvimrc

" Disable so we can do it ourselves and avoid <M-Down> overriding vim-visual-multi
" And have VimR behave the same as MacVim
let macvim_skip_cmd_opt_movement = 1

no   <D-Left>       <Home>
no!  <D-Left>       <Home>
" Go for word, not WORD
"no   <M-Left>       <C-Left>
"no!  <M-Left>       <C-Left>

no   <D-Right>      <End>
no!  <D-Right>      <End>
" Go for word, not WORD
"no   <M-Right>      <C-Right>
"no!  <M-Right>      <C-Right>

no   <D-Up>         <C-Home>
ino  <D-Up>         <C-Home>
"no   <M-Up>         {
"ino  <M-Up>         <C-o>{

no   <D-Down>       <C-End>
ino  <D-Down>       <C-End>
"no   <M-Down>       }
"ino  <M-Down>       <C-o>}

ino  <M-BS>         <C-w>
ino  <D-BS>         <C-u>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Emulate common GUI apps {{{1

""" General {{{2

" TODO: could be used as chord prefix cause they're not that useful
call MapSuperKey('q', '<Cmd>confirm qall<CR>')
call MapSuperKey('n', '<Cmd>new<CR>')

call MapSuperKey('e', '<C-F2>', 'all', v:false, v:true)
" NOTE: <C-S-F2> doesn't match the meaning of "Recent Locations" in JetBrains
call MapSuperKey('E', '<C-S-F2>', 'all', v:false, v:true)
call MapSuperKey('F', '<C-F3>', 'all', v:false, v:true)
call MapSuperKey('p', '<C-F4>', 'all', v:false, v:true)
call MapSuperKey('"', '<C-F10>', 'all', v:false, v:true)

call MapControlKey('X', '<Cmd>PlugClean<CR><Cmd>PlugInstall<CR>')
call MapControlKey('"', '<Cmd>verbose map<CR>')

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
call MapControlKey('Bar', '<Cmd>call ToggleSplitOrientation()<CR>', 'all', v:true)

" Equalize splits
call MapSuperOrControlKey('M-)', '<C-w>=')

" Maximize split
if exists('g:gui_running')
    let s:key = '<M-S-D-Bar>'
else
    let s:key = '<M-C-Bar>'
endif
call MapKey(s:key, '<C-w>_', ['nnoremap'])
call MapKey(s:key, '<C-o><C-w>_<C-o><C-w><Bar>', ['noremap!'])
call MapKey(s:key, '<C-\><C-N><C-w>_<C-\><C-N><C-w><Bar>', ['tnoremap'])

" Change split size
call MapKey('<M-C-S-Up>', '2<C-w>+')
call MapKey('<M-C-S-Down>', '2<C-w>-')
call MapKey('<M-C-S-Left>', '4<C-w><lt>')
call MapKey('<M-C-S-Right>', '4<C-w>>')

" Move splits
call MapKey('<C-M-D-Up>', '<C-w>K')
call MapKey('<C-M-D-Down>', '<C-w>J')
call MapKey('<C-M-D-Left>', '<C-w>H')
call MapKey('<C-M-D-Right>', '<C-w>L')


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
" Since MacVim/VimR already define ⌘1, we'll just use map ⌥ for consistency across
" UIs. We can't use ⌃ because ⌃6 is special (and ⌃2 may also act funny). But that's
" ok as we can use BTT to remap.
call MapKey('<M-1>', '<Cmd>tabn 1<CR>')
call MapKey('<M-2>', '<Cmd>tabn 2<CR>')
call MapKey('<M-3>', '<Cmd>tabn 3<CR>')
call MapKey('<M-4>', '<Cmd>tabn 4<CR>')
call MapKey('<M-5>', '<Cmd>tabn 5<CR>')
call MapKey('<M-6>', '<Cmd>tabn 6<CR>')
call MapKey('<M-7>', '<Cmd>tabn 7<CR>')
call MapKey('<M-8>', '<Cmd>tabn 8<CR>')
call MapKey('<M-9>', '<Cmd>tablast<CR>')
call MapKey('<M-{>', '<Cmd>tabprev<CR>')
call MapKey('<M-}>', '<Cmd>tabnext<CR>')

call MapControlKey('{', '<Cmd>-tabmove<CR>')
call MapControlKey('}', '<Cmd>+tabmove<CR>')
call MapSuperOrControlKey('M-{', '<Cmd>0tabmove<CR>')
call MapSuperOrControlKey('M-}', '<Cmd>$tabmove<CR>')

""" Movement {{{2

" Wrapped line navigation
call MapKey('<Up>', 'gk')
call MapKey('<Down>', 'gj')

call MapKey('<M-Left>', 'b')
call MapKey('<M-Right>', 'w')

" Move cursor
" NOTE: we don't do this in TUIs because <M-Arrow> is reserved for vim-move
if exists('g:gui_running')
    call MapSuperKey('Up', 'gg')
    call MapSuperKey('Down', 'G')
    call MapSuperKey('Left', '0')
    call MapSuperKey('Right', '$')
endif

" Go back/forward and/or CamelCaseMotion
" NOTE: Luckily, iTerm passes <M-D-arrows> through
call MapKey('<M-D-Left>', '<C-O>')
call MapKey('<M-D-Right>', '<C-I>')
call MapKey('<C-Left>', '<Plug>CamelCaseMotion_b')
call MapKey('<C-Right>', '<Plug>CamelCaseMotion_w')

" Go to previous edit location and Delete parts of line
call MapSuperKey('S-BS', 'g;')
call MapSuperOrControlKey('M-S-BS', 'g,')
call MapSuperKey('Del', 'D')
call MapSuperKey('BS', 'd0')

" Go to previous/next git change
call MapKey('<C-S-Up>', '[c', 'all', v:false, v:true)
call MapKey('<C-S-Down>', ']c', 'all', v:false, v:true)

" Go to previous/next method
call MapKey('<C-Up>', '[m')
call MapKey('<C-Down>', ']m')

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

""" Fold {{{2

" 2022-11-14 MacVim doesn't support modifyOtherKeys yet
" We could fall back to using the meta key but right :alembic:plug
call MapControlKey('-', 'zc')
call MapControlKey('=', 'zo')
call MapControlKey('_', 'zM')
call MapControlKey('+', 'zR')

""" expand-region {{{2

map <S-D-Up> <Plug>(expand_region_expand)
map <S-D-Down> <Plug>(expand_region_shrink)
if exists('g:tui_running')
    " iTerm doesn't send the ⌘ modifier
    map <S-Up> <Plug>(expand_region_expand)
    map <S-Down> <Plug>(expand_region_shrink)
endif

""" visual-multi {{{2

let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'

" Free up <C-g> for visual-multi
" We could use `:f` in the general case but we still need `1<C-q><C-g>` for full path
nnoremap <C-q><C-g> <C-g>

" We prefer to add not replace the existing defaults, so we don't use g:VM_maps
" Because \\gS is hard to remember
exe 'nnoremap ' . g:NormalizeMetaModifier('<C-g>') . ' <Plug>(VM-Find-Under)'
nnoremap \\S <Plug>(VM-Reselect-Last)
exe 'nnoremap ' . g:NormalizeMetaModifier('<M-?>') . ' <Plug>(VM-Start-Regex-Search)'
exe 'nnoremap ' . g:NormalizeMetaModifier('<M-G>') . ' <Plug>(VM-Select-All)'
exe 'xnoremap ' . g:NormalizeMetaModifier('<M-G>') . ' <Plug>(VM-Visual-All)'
" This is like "Add cursors to line ends"
exe 'xnoremap ' . g:NormalizeMetaModifier('<M-I>') . ' <Plug>(VM-Visual-Cursors)'
" In any case, these don't work
"   let g:VM_maps["Find Previous"] = '<C-S-N>'
"   let g:VM_maps["Select All Words"] = g:NormalizeMetaModifier('<M-G>')
" even if these do:
"   let g:VM_maps["Skip Region"] = g:NormalizeMetaModifier('<M-q>')
"   let g:VM_maps["Remove Region"] = g:NormalizeMetaModifier('<M-Q>')
"   let g:VM_maps["Visual All"] = g:NormalizeMetaModifier('<M-G>')
function! VM_Start()
    nnoremap <buffer> <C-S-G> <Plug>(VM-Find-Prev)
    exe 'nnoremap <buffer> ' . g:NormalizeMetaModifier('<M-q>') . ' <Plug>(VM-Skip-Region)'
    exe 'nnoremap <buffer> ' . g:NormalizeMetaModifier('<M-Q>') . ' <Plug>(VM-Remove-Region)'
endfunction
function! VM_Exit()
    nunmap <buffer> <C-S-G>
    exe 'nunmap <buffer> ' . g:NormalizeMetaModifier('<M-q>')
    exe 'nunmap <buffer> ' . g:NormalizeMetaModifier('<M-Q>')
endfunction

let g:VM_maps["Add Cursor Up"] = '<M-Up>'
let g:VM_maps["Add Cursor Down"] = '<M-Down>'
"exe 'nnoremap ' . g:NormalizeMetaModifier('<M-Up>') . ' <Plug>(VM-Add-Cursor-Up)'
"exe 'xnoremap ' . g:NormalizeMetaModifier('<M-Up>') . ' <Plug>(VM-Add-Cursor-Up)'
"exe 'nnoremap ' . g:NormalizeMetaModifier('<M-Down>') . ' <Plug>(VM-Add-Cursor-Down)'
"exe 'xnoremap ' . g:NormalizeMetaModifier('<M-Down>') . ' <Plug>(VM-Add-Cursor-Down)'

" NOTE: we can't use <C-Leftmouse> because that's already mapped to looking up tags
" NOTE: we can't use <C-S-RightMouse> because MacVim doesn't pass it through,
"   even if we did already liberate <C-LeftMouse> with:
"   `defaults write org.vim.MacVim MMTranslateCtrlClick 0` to disable the context menu
" NOTE: iTerm2 sends Cmd+Click as <M-LeftMouse>
let g:VM_maps["Mouse Cursor"] = '<M-RightMouse>'
let g:VM_maps["Mouse Word"] = '<M-MiddleMouse>'
let g:VM_maps["Mouse Column"] = '<S-M-RightMouse>'

""" vim-move {{{2

call MapKey('<C-M-Down>', '<Plug>MoveLineDown', ['nmap', 'map!'])
call MapKey('<C-M-Up>', '<Plug>MoveLineUp', ['nmap', 'map!'])
call MapKey('<C-M-Left>', '<Plug>MoveCharLeft', ['nmap', 'map!'])
call MapKey('<C-M-Right>', '<Plug>MoveCharRight', ['nmap', 'map!'])
call MapKey('<C-M-Up>', '<Plug>MoveBlockUp', ['vmap'])
call MapKey('<C-M-Down>', '<Plug>MoveBlockDown', ['vmap'])
call MapKey('<C-M-Left>', '<Plug>MoveBlockLeft', ['vmap'])
call MapKey('<C-M-Right>', '<Plug>MoveBlockRight', ['vmap'])

" if exists('g:gui_running')
"     nmap <M-Down> <Plug>MoveLineDown
"     nmap <M-Up> <Plug>MoveLineUp
"     nmap <M-Left> <Plug>MoveCharLeft
"     nmap <M-Right> <Plug>MoveCharRight
"     vmap <M-Down> <Plug>MoveBlockDown
"     vmap <M-Up> <Plug>MoveBlockUp
"     vmap <M-Left> <Plug>MoveBlockLeft
"     vmap <M-Right> <Plug>MoveBlockRight
" else
"     nmap <Esc><Down> <Plug>MoveLineDown
"     nmap <Esc><Up> <Plug>MoveLineUp
"     nmap <Esc><Left> <Plug>MoveCharLeft
"     nmap <Esc><Right> <Plug>MoveCharRight
"
"     " WARNING: if instead of using h,j,k,l, you tend to use arrow keys for motion
"     " in Normal mode, then the mappings below may interfere when you try to exit
"     " out of Visual mode with <Esc> and immediately hit an arrow key. In that
"     " case, you might want to use the `C` modifier instead as here:
"     "vmap <C-Down> <Plug>MoveBlockDown
"     "vmap <C-Up> <Plug>MoveBlockUp
"     "vmap <C-Left> <Plug>MoveBlockLeft
"     "vmap <C-Right> <Plug>MoveBlockRight
"     vmap <Esc><Down> <Plug>MoveBlockDown
"     vmap <Esc><Up> <Plug>MoveBlockUp
"     vmap <Esc><Left> <Plug>MoveBlockLeft
"     vmap <Esc><Right> <Plug>MoveBlockRight
" endif


""" Edit text {{{2

" Insert empty line above/below
call MapKey('<C-CR>', 'o')
call MapKey('<S-C-CR>', 'O')

" Delete lines
call MapKey('<C-S-BS>', 'dd')

" Increment/Decrement/Toggle
" Allow remapping so that they work for tpope/vim-speeddating
call MapSuperOrControlKey('M-+', '<C-a>', 'all', v:false, v:true)
call MapSuperOrControlKey('M-_', '<C-x>', 'all', v:false, v:true)
call MapKey('<M-X>', '<Cmd>set opfunc=switch#OpfuncForward<CR>g@l', ['nmap'])
call MapKey('<M-X>', '<Cmd>set opfunc=switch#OpfuncForward<CR>g@lgv', ['vmap'])
call MapKey('<M-X>', '<Cmd>set opfunc=switch#OpfuncForward<CR><C-o>g@l', ['map!'])

""" Edit code {{{2

" Shift argument (using vim-argumentative)
call MapSuperOrControlKey('M-lt', '<,', 'all', v:false, v:true)
call MapSuperOrControlKey('M->', '>,', 'all', v:false, v:true)

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

""" Code navigation {{{2

call MapKey('<F1>' , 'K', 'all', v:false, v:true)
call MapSuperKey('b', 'gd', 'all', v:false, v:true)
call MapSuperKey('B', 'gy', 'all', v:false, v:true)
call MapSuperOrControlKey('M-b', 'gi', 'all', v:false, v:true)
call MapSuperKey('y', '<Cmd>vsplit<CR>gd', 'all', v:false, v:true)
call MapSuperKey('Y', '<Cmd>vsplit<CR>gy', 'all', v:false, v:true)
call MapSuperKey('i', 'gR', 'all', v:false, v:true)

""" Markdown {{{2

call MapKey('<M-m>p', '<Cmd>MarkdownPreview<CR>')
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

" Shift argument (using vim-argumentative)
"call MapSuperOrControlKey('lt', '', 'all', v:false, v:true)
call MapSuperKey('>', '<Cmd>ToggleCB<CR>')

""" Markdown table mode {{{2

call MapKey('<M-m>t', '<Leader>tm', 'all', v:false, v:true)
call MapKey('<M-m>f', '<Leader>tr', 'all', v:false, v:true)
call MapKey('<M-m>i', '<Leader>tiC', 'all', v:false, v:true)
call MapKey('<M-m>a', '<Leader>tic', 'all', v:false, v:true)
call MapKey('<M-m>x', '<Leader>tdc', 'all', v:false, v:true)
call MapKey('<M-m>d', '<Leader>tdd', 'all', v:false, v:true)

autocmd FileType markdown call MapKey('<M-[>', '[<Bar>', ['map', 'imap'], v:false, v:true, '<buffer>')
autocmd FileType markdown call MapKey('<M-]>', ']<Bar>', ['map', 'imap'], v:false, v:true, '<buffer>')

""" Terminal {{{2

call MapKey('<M-F12>', '<Cmd>call OpenTerminal()<CR>')
if exists('g:nvim')
    call MapKey('<M-o>t', ':<C-u>call RevealInTerminal()<CR>')
else
    call MapKey('<M-o>t',
                \ '<Cmd>let $_term_dir = expand("%:p:h")<CR>' .
                \ '<Cmd>call RevealInTerminal()<CR>' .
                \ 'cd $_term_dir; unset _term_dir<CR>')
endif

" XXX Don't know why <M-o><M-t> doesn't work.
call MapKey('<M-o>T', '<Cmd>!iterm2-new-tab-with-path %:p:h<CR>')

""" Internal Apps {{{2

call MapKey('<M-s>i', '<Cmd>verb Sleuth<CR>')
if exists('g:nvim')
    call MapControlKey('F', '<Cmd>NvimTreeFindFile<CR>')
else
    call MapControlKey('F', '<Cmd>NERDTreeFind<CR>')
endif
" Insert gitmoji
map! <M-x>: <C-x><C-u>

""" External Apps {{{2

if has('mac')
    call MapKey('<M-o>/', '<Plug>DashSearch')
    call MapKey('<M-o>?', '<Plug>DashGlobalSearch')
endif
call MapKey('<M-o>g', '<Plug>SearchNormal', ['map'])
call MapKey('<M-o>g', '<Plug>SearchVisual', ['vmap'])
" NOTE: for some reason `<Cmd>` doesn't work right in visual mode, so use `:`
"   https://github.com/voldikss/vim-browser-search/issues/28
call MapKey('<M-o>w', ':BrowserSearch<CR>')
" FIXME: 2022-11-12 cheat.sh API may have changed
call MapKey('<M-o>p', '<Leader>KB', 'all', v:false, v:true)

call MapKey('<M-o>f', '<Cmd>Reveal<CR>')
call MapKey('<M-o>c', '<Cmd>CodeCurrent<CR>')

""" System clipboard {{{2

" GUI apps should already have the ⌘ versions mapped
if exists('g:tui_running')
    vnoremap <C-S-x> "+d
    vnoremap <C-S-c> "+y
    vnoremap <C-S-v> "+gP
    nnoremap <C-S-v> "+gP
    cnoremap <C-S-v> <C-R>+
    inoremap <C-S-v> <C-R><C-O>+
endif

""" Settings {{{2

call MapKey('<M-s>w', '<Cmd>set wrap!<CR>')
call MapKey('<M-s>b', '<Cmd>call ToggleBackground()<CR>')
call MapKey('<M-s>c', '<Cmd>call ToggleColorscheme()<CR>')
call MapKey('<M-s>C', '<Cmd>HexokinaseToggle<CR>')
call MapKey('<M-s>/', '<Cmd>call EregexToggle()<CR>')


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prologue {{{1

" vim:foldmethod=marker:
