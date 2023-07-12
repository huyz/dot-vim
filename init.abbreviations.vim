""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Complex abbreviations

" Inserts a row of '*' characters up to the 78th column
inoremap <Leader>`** <Esc>80a*<Esc>78\|C
" Inserts a row of '#' characters up to the 78th column
inoremap <Leader>`## <Esc>80a#<Esc>78\|C
" Inserts a row of '-' characters up to the 78th column
inoremap <Leader>`-- <Esc>80a-<Esc>78\|C
" Inserts a row of '- ' characters up to the 78th column
inoremap <Leader>`-<Space> <Esc>40a- <Esc>78\|C

" Inserts current date at insertion point (See ~/.vim/.vimrc.post for more)
inoremap <Leader>`d <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <Leader>`D <C-R>=system("echo -n $(date -Iseconds)")<CR>
inoremap <Leader>`t <C-R>=strftime("%T")<CR>
inoremap <Leader>`u <C-R>=system("echo -n $(date -Idate -u)")<CR>
inoremap <Leader>`U <C-R>=system("echo -n $(date -Iseconds -u \| sed 's/+00:00/Z/')")<CR>
iab ---: ---<CR>author: <C-R>=$LOGNAME<CR><CR>created: '<Leader>`D'<CR>updated: '<Leader>`D'<CR>---

