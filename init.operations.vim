""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Complex operations

""" Utils {{{1

" Utility functions for macros below
" (Remembers the last search, removes the `highlight`, and recovers old position)
noremap <Leader>_do_ <Cmd>let hls=@/<CR>
noremap <Leader>_done_ <Cmd>let @/=hls<CR><Cmd>nohl<CR><C-O>


""" Indentation {{{1

" Halve the indentation of the file, assuming spaces
" NOTE: makes sense only with expandtab on
" TODO: doesn't work on mac
nmap <Leader><TAB>< <Leader>_do_:%!unexpand --first-only -t 2<CR>:%!expand --initial -t 1<CR><Leader>_done_
" Double the indentation of the file, assuming spaces
nmap <Leader><TAB>> <Leader>_do_:%s/^\(\s*\)/\1\1/<CR><Leader>_done_

" Discard consecutive blank lines
nmap <Leader>t0 <Leader>_do_:v/./.,/./-1join<CR><Leader>_done_


""" Complex edits {{{1

" Underlines the current line with '~', '-', '=' characters (good for markdown)
nmap <Leader>= <Leader>_do_yyp:s/./=/g<CR><Leader>_done_
nmap <Leader>- <Leader>_do_yyp:s/./-/g<CR><Leader>_done_
nmap <Leader>~ <Leader>_do_yyp:s/./\~/g<CR><Leader>_done_


""" Swap last two words {{{1
" Requires: vim-exchange

" https://github.com/tommcdo/vim-exchange/issues/58#issuecomment-1284067044
" Usage: cursor must be on any character of the second word
function! s:SwapLastTwoWords()
    " First, go to last character  of last word, even if the Word is one long character
    normal viW
    let l:pos = getpos('.')
    normal XBcxiW
    call setpos('.', l:pos)
endfunction

" Usage: cursor must be right before second word, inside the word, or after
"   any whitespace after the word
function! s:SwapLastTwoWordsInInsertMode()
    let l:addone = 0
    let l:beyondeol = 0
    let l:pos = getpos('.')
    if col(".") == col("$")
        let l:beyondeol = 1
    endif
    normal \<Esc>
    if getline('.')[col('.')-1] =~ "\\s"
        " If on whitespace, go back one word
        normal gE
    else
        " If inside word, then let's make sure we move the cursor to end of word
        " because the left word could be shorter than the second word
        exe "normal! viW\<Esc>"
        let l:pos = getpos('.')
        let l:addone = 1
    endif
    normal cxiWB.
    call setpos('.', l:pos)
    if l:beyondeol
        normal $
    elseif l:addone
        normal l
    endif
endfunction

nnoremap <silent> <M-s> :<C-u>call <SID>SwapLastTwoWords()<CR>
" NOTE: we can't use <Cmd> because we actually want a mode change to normal
"   inside function to look at whitespace
imap <silent> <M-s> <C-\><C-o>:<C-u>call <SID>SwapLastTwoWordsInInsertMode()<CR>

