""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Terminal

" Usage:
"     <M-[>   Go to terminal Normal mode
"   vim and not neovim:
"     <C-W> .   Send <C-w> to terminal

if has("nvim")
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
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
call Keymap('<M-F12>', '<Cmd>call OpenTerminal()<CR>')

" Convenience map of <M-[> for escaping to normal mode, which is easier to
" press than <C-\><C-N>
call Keymap('<M-[>', '<C-\><C-N>', ['tnoremap'])
