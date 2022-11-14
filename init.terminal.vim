""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Terminal

" Usage:
"     <M-[>   Go to terminal Normal mode
"   vim and not neovim:
"     <C-W> .   Send <C-w> to terminal

if exists('g:nvim')
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
    if exists('g:nvim')
        split term://zsh
    else
        terminal ++close
    endif
    resize 10
endfunction
" Open in current buffer's directory
function! RevealInTerminal()
    let l:dir = expand('%:p:h')
    if exists('g:nvim')
        below new
        call termopen([&shell], {'cwd': expand('%:p:h') })
        normal i
    else
        terminal ++close
        " XXX Can't figure out how to change the diretory from within a function.
        "   So we have to do it in the mapping.
    endif
    resize 10
endfunction

" Convenience map of <M-[> for escaping to normal mode, which is easier to
" press than <C-\><C-N>
call MapKey('<M-[>', '', ['tnoremap'])

" For <C-/> to work in FZF window to toggle preview side view
" NOTE: Doesn't work in MacVim (and other UIs may beep); using <C-_> is better
tmap <C-/> <C-_>
