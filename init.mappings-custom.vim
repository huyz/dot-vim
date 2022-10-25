""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Function keys {{{1

" Normal function key mappings (these don't change)
if has("nvim")
    nnoremap <F1> <Cmd>NvimTreeToggle<CR>
else
    nnoremap <F1> <Cmd>NERDTreeToggle<CR>
endif
call MapKey('<S-F1>', '<Cmd>helpclose<CR>')
nmap <F2> <Cmd>CtrlPBuffer<CR>
nmap <F3> <Cmd>RG<CR>
nmap <F4> <Cmd>FZF<CR>
nmap <F5> <Leader>o1
nmap <F6> <Leader>o2
nmap <F7> <Cmd>SymbolsOutline<CR>
"nmap <F8> <Leader>o4
nmap <F9> <Cmd>LazyGit<CR>
"nmap <F10>
nmap <F11> <Leader>o3
nmap <F12> <Leader>o4

" Make pastetoggle also work in insert mode
set pastetoggle=<F5>

" Aliases if function keys don't get passed through by the terminal
nmap <Leader>f1 <F1>
nmap <Leader>f2 <F2>
nmap <Leader>f3 <F3>
nmap <Leader>f4 <F4>
nmap <Leader>f5 <F5>
nmap <Leader>f6 <F6>
nmap <Leader>f7 <F7>
nmap <Leader>f8 <F8>
nmap <Leader>f9 <F9>
nmap <Leader>f0 <F10>
nmap <Leader>F1 <F11>
nmap <Leader>F2 <F12>


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
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" Suspend from insert mode
noremap! <C-z> <Esc><C-z>

" Edit .vimrc
nnoremap <Leader>vi <Cmd>e $MYVIM/.vimrc<CR>
" Re-source .vimrc
nnoremap <Leader>so <Cmd>so $MYVIM/.vimrc<CR>
" Quick-save and reload .vimrc
" NOTE: MacVim and VimR already handle <D-s>
nmap <C-s> <Cmd>write<CR><Leader>so
imap <C-s> <Cmd>write<CR><C-o><Leader>so

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
