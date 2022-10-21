""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Functions to cycle/toggle display modes

" Cycle textwidth
function! CycleTextwidth()
    if &textwidth == 0
        set textwidth=78
    elseif &textwidth == 78
        set textwidth=98
    elseif &textwidth == 98
        set textwidth=118
    else
        set textwidth=0
    endif
    echo "textwidth=" . &textwidth
endfunction

" Toggle virtual movement, which is useful for editing tables
" By default, we have "block,insert" set
function! ToggleVirtualEdit()
    if &virtualedit == "block,insert"
        nnoremap r gr
        nnoremap R gR
        nnoremap k gk
        nnoremap j gj
        nnoremap <Up> k
        nnoremap <Down> j
        set virtualedit=all
        set virtualedit?
    else
        nunmap r
        nunmap R
        nunmap k
        nunmap j
        nnoremap <Up> gk
        nnoremap <Down> gj
        set virtualedit=block,insert
        set virtualedit?
    endif
endfunction

function! CycleEditDisplay()
    if exists('b:CycleEditDisplay_init')
        let l:init = 1
        unlet b:CycleEditDisplay_init
        let b:CycleEditDisplay_mode = 'init'
    endif
    if b:CycleEditDisplay_mode == 'default'
        let b:CycleEditDisplay_mode = 'full'
        set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
        set   list   number   relativenumber   cursorline showbreak=↪
        set colorcolumn=+1,80,100,120
    elseif b:CycleEditDisplay_mode == 'full'
        let b:CycleEditDisplay_mode = 'none'
        set listchars=tab:→\ ,nbsp:␣,trail:·,precedes:«,extends:»
        set nolist nonumber norelativenumber nocursorline showbreak=  nocursorcolumn
        set colorcolumn=
    else
        let b:CycleEditDisplay_mode = 'default'
        set listchars=tab:→\ ,nbsp:␣,trail:·,precedes:«,extends:»
        set   list   number   relativenumber   cursorline showbreak=↪
        set colorcolumn=+1,80,100,120
    endif
    if !exists('l:init')
        echo 'b:CycleEditDisplay_mode=' . b:CycleEditDisplay_mode
    endif
endfunction
let b:CycleEditDisplay_init = 1
call CycleEditDisplay()
