""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Terminal

" Usage:
"     <M-[>   Go to terminal Normal mode
"   vim and not neovim:
"     <C-W> .   Send <C-w> to terminal

if has("nvim")
    autocmd TermOpen * setlocal nonumber norelativenumber
    " NOTE: added lazygit check to avoid lua error
    " NOTE: added "silent!" to avoid error when FZF terminal window is closed.
    autocmd TermClose * if &filetype != 'lazygit' && !v:event.status | silent! exe 'bdelete! '..expand('<abuf>') | endif
else
    autocmd TerminalWinOpen * setlocal nonumber norelativenumber
endif
" Start terminal in insert mode when switching to it
autocmd BufEnter * if &buftype == 'terminal' | set nonumber norelativenumber | :startinsert | endif
" Close terminal buffers if the job exited without error

" Open terminal with opt+F12 (just like in JetBrains).
function! OpenTerminal()
    if has("nvim")
        split term://zsh
    else
        terminal ++close
    endif
    resize 10
endfunction
" Open in current buffer's directory
function! RevealInTerminal()
    let l:dir = expand('%:p:h')
    if has("nvim")
        below new
        call termopen([&shell], {'cwd': l:dir })
        normal i
    else
        terminal ++close
        cd l:dir
    endif
    resize 10
endfunction

" Convenience map of <M-[> for escaping to normal mode, which is easier to
" press than <C-\><C-N>
call MapKey('<M-[>', '<C-\><C-N>', ['tnoremap'])

" For <C-/> to work in FZF window
" NOTE: Doesn't work in MacVim (and other UIs may beep); using <C-_> is better
tmap <C-/> <C-_>
