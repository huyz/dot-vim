""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Function keys {{{1

" NOTE: reserving F1 for documentation lookup
if has("nvim")
    nnoremap <C-F1> <Cmd>NvimTreeToggle<CR>
else
    nnoremap <C-F1> <Cmd>NERDTreeToggle<CR>
endif
if has('nvim') && !has('gui_running')
    call MapKey('<F13>', '<Cmd>helpclose<CR>')
else
    call MapKey('<S-F1>', '<Cmd>helpclose<CR>')
endif
if has('nvim')
    nmap <C-F2> <Cmd>Telescope buffers<CR>
    nmap <C-F3> <Cmd>Telescope live_grep<CR>
    nmap <C-F4> <Cmd>Telescope find_files<CR>
    nmap <C-S-F2> <Cmd>CtrlPBuffer<CR>
    nmap <C-S-F3> <Cmd>RG<CR>
    nmap <C-S-F4> <Cmd>FZF<CR>
else
    nmap <C-F2> <Cmd>CtrlPBuffer<CR>
    nmap <C-F3> <Cmd>RG<CR>
    nmap <C-F4> <Cmd>FZF<CR>
endif
nmap <F5> <Leader>o1
nmap <F6> <Leader>o2
nmap <C-F7> <Cmd>SymbolsOutline<CR>
"nmap <F8> <Leader>o4
nmap <C-F9> <Cmd>LazyGit<CR>
nmap <C-F10> <Cmd>Startify<CR>
nmap <F11> <Leader>o3
nmap <F12> <Leader>o4

" Make pastetoggle also work in insert mode
set pastetoggle=<F5>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Display modes {{{1

" Different display options
nnoremap <Leader>o0 <Cmd>set sts=2 sw=2 wrap linebreak showbreak=↪ number
    \ relativenumber cursorline nocursorcolumn colorcolumn=+1,80,100,120<CR>
nmap <Leader>o1 <Cmd>set invpaste<CR><Cmd>GitGutterToggle<CR>
    \<Cmd>call CycleEditDisplay(&paste)<CR><Cmd>set paste?<CR>
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

" Case-insensitive search (doesn't make sense to set 'ignorecase'
" as it's dangerous for substitutions)
" NOTE: \v isn't completely like perl, even with the basics, because
" the charaters <>= are now special that weren't with perl
nnoremap / /\c
nnoremap ? ?\c

" Folding http://vim.wikia.com/wiki/Folding
nnoremap <silent> <Space><Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space><Space> zf

" Suspend from insert mode
noremap! <C-z> <Esc><C-z>


" Edit .vimrc
nnoremap <Leader>vi <Cmd>e $MYVIM/.vimrc<CR>
" Re-source .vimrc and re-run Sleuth
nnoremap <Leader>so <Cmd>so $MYVIM/.vimrc<CR><Cmd>silent! Sleuth<CR><Cmd>echo 'Re-sourced'<CR>
" Quick-save and re-source .vimrc, using emacs keybinding
" NOTE: MacVim and VimR already handle <D-s>
nmap <C-x><C-s> <Cmd>write<CR><Leader>so
imap <C-x><C-s> <Cmd>write<CR><C-o><Leader>so

" Allow saving of files as sudo when you forget to start vim using sudo.
" Shortcut matches my zsh binding
cnoremap <C-x><C-s> w !sudo tee > /dev/null %

" Closes buffer without messing up split window
" (goes to the next buffer first so that the split window is not closed)
" 2022-10-25 Now use bbye plugin
"noremap <C-w><C-q> <Cmd>bnext<CR><Cmd>bdel #<CR>

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
