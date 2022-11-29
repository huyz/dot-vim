""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Function keys {{{1

" NOTE: reserving F1 for documentation lookup
if exists('g:nvim')
    nnoremap <C-F1> <Cmd>NvimTreeToggle<CR>
else
    nnoremap <C-F1> <Cmd>NERDTreeToggle<CR>
endif
if exists('g:tui_nvim')
    call MapKey('<F13>', '<Cmd>helpclose<CR>')
else
    call MapKey('<S-F1>', '<Cmd>helpclose<CR>')
endif
call MapKey('<C-S-F1>', '<Cmd>messages<CR>')

" Override default so that we don't have the slow preview
command! -bar -bang -nargs=? -complete=buffer MyBuffers  call fzf#vim#buffers(<q-args>, <bang>0)'
" But FZF is too slow
"nmap <C-F2> <Cmd>MyBuffers<CR>
nmap <C-F2> <Cmd>CtrlPBuffer<CR>

if exists('g:nvim')
    " Until telescope can do this: https://github.com/nvim-telescope/telescope.nvim/issues/2188
    "nmap <C-F2> <Cmd>Telescope buffers show_all_buffers=false ignore_current_buffer=true sort_mru=true<CR>
    nmap <C-S-F2> <Cmd>Telescope buffers sort_mru=true<CR>
    nmap <C-F3> <Cmd>Telescope live_grep<CR>
    nmap <C-S-F3> <Cmd>Telescope live_grep no_ignore=true follow=true<CR>
    nmap <C-F4> <Cmd>Telescope find_files<CR>
    nmap <C-S-F4> <Cmd>Telescope find_files no_ignore=true follow=true<CR>
else
    nmap <C-F3> <Cmd>Rg<CR>
    nmap <C-S-F3> <Cmd>RG<CR>
    nmap <C-F4> <Cmd>GFiles --cached --others --exclude-standard<CR>
    nmap <C-S-F4> <Cmd>FZF<CR>
endif

nmap <F5> <Leader>o1
" Make pastetoggle also work in insert mode
set pastetoggle=<F5>
" Free up <C-p> for other uses (2022-11-10 for coc): use <C-F5>
let g:ctrlp_map = '<C-F5>'

nmap <F6> <Leader>o2
nmap <C-F7> <Cmd>SymbolsOutline<CR>

if exists('g:nvim')
    nmap <C-F9> <Cmd>LazyGit<CR>
endif
nmap <C-F10> <Cmd>Startify<CR>
nmap <F11> <Leader>o3
nmap <F12> <Leader>o4
nmap <C-F12> <Cmd>UndotreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Display modes {{{1

" Different display options
nnoremap <Leader>o0 <Cmd>set sts=2 sw=2 wrap linebreak showbreak=↪ number
    \ relativenumber cursorline nocursorcolumn colorcolumn=+1,80,100,120<CR>
nnoremap <Leader>o1 <Cmd>call TogglePaste()<CR>
nnoremap <Leader>o2 <Cmd>call CycleEditDisplay()<CR>
nnoremap <Leader>o3 <Cmd>call CycleTextwidth()<CR>
nnoremap <Leader>o4 <Cmd>call ToggleVirtualEdit()<CR>
"nnoremap <Leader>o5 <Cmd>!elinks -default-mime-type "text/html" file://%<CR>

" Indentation options
nnoremap <Leader>t1 <Cmd>set et<CR><Cmd>set sts=2 sw=2<CR>
nnoremap <Leader>t2 <Cmd>set et<CR><Cmd>set sts=4 sw=2<CR>
nnoremap <Leader>t3 <Cmd>set et<CR><Cmd>set sts=8 sw=4<CR>
nnoremap <Leader>t4 <Cmd>set noet<CR><Cmd>set sts=8 sw=8<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Misc {{{1

" Folding http://vim.wikia.com/wiki/Folding
nnoremap <silent> <Space><Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space><Space> zf

" Suspend from any mode, liberating <C-z> for toggling value
call MapKey('<C-S-z>', '<C-z>')

" Closing without saving
nmap Zw <Cmd>bdelete!<CR>
" Save all and exit
nmap ZA <Cmd>confirm qall<CR>
" Closes buffer without messing up split window
" (goes to the next buffer first so that the split window is not closed)
" 2022-10-25 Now use bbye plugin
"noremap <C-w><C-q> <Cmd>bnext<CR><Cmd>bdel #<CR>
" Switch to alternate buffer
call MapKey('<M-a>', '<C-^>')
" Edit .vimrc
call MapKey('<C-q><C-e>', '<Cmd> $MYVIM/.vimrc<CR>')
" Reload configs and re-run Sleuth
call MapKey('<C-q><C-r>', '<Cmd>so $MYVIM/.vimrc<CR><Cmd>silent! Sleuth<CR><Cmd>syn on<CR><Cmd>echo "Configs reloaded"<CR>')
" Save buffer
" NOTE: MacVim and VimR already map <D-s>
" NOTE: we don't use MapControlKey because we don't want to conflict with <M-s>, which is one of
"   our chord prefixes
call MapKey('<C-s>', '<Cmd>write<CR>')
" Save buffer and reload configs
" NOTE: we don't use MapControlKey because we don't want to conflict with <M-q>
call MapKey('<C-q><C-s>', '<Cmd>write<CR><C-q><C-r>', 'all', v:false, v:true)

" Allow saving of files as sudo when you forget to start vim using sudo.
" Shortcut matches my zsh binding
cnoremap <C-x><C-s> w !sudo tee > /dev/null %


" Use Q for par formating
" NOTE: regular formatting is still done with `gq` and emacs formatting with <M-q>
vnoremap Q !par -w<CR>

" Select last pasted block
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Typo Corrections {{{1

" I hold <shift> too long when typing ':'
" NOTE: we add the ! so we can re-source .vimrc
command! Q q
command! Qa qa
command! QA qa
command! W w

" vim:foldmethod=marker:
