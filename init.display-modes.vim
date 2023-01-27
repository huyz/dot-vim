""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Functions to cycle/toggle display modes

" Toggle paste
function! TogglePaste()
    if exists('b:old_signcolumn')
        let &signcolumn = b:old_signcolumn
        unlet b:old_signcolumn
    elseif &signcolumn != 'no'
        let b:old_signcolumn = &signcolumn
        set signcolumn=no
    endif
    if exists('g:coc_running')
        call coc#config('git', {'addGBlameToVirtualText': &paste})
        " Clear the virtual text on the current line
        call nvim_buf_clear_namespace(bufnr(), -1, line('.') - 1, line('.'))
    endif
    set invpaste
    GitGutterToggle
    call CycleEditDisplay(&paste)
    set paste?
endfunction

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
" By default, we have "block" set
function! ToggleVirtualEdit()
    if &virtualedit == "block"
        nnoremap r gr
        nnoremap R gR
        nnoremap k gk
        nnoremap j gj
        nnoremap <Down> j
        nnoremap <Up> k
        xnoremap <Down> j
        xnoremap <Up> k
        set virtualedit=all
        set virtualedit?
    else
        nunmap r
        nunmap R
        nunmap k
        nunmap j
        nnoremap <Down> gj
        nnoremap <Up> gk
        noremap <Down> gj
        xnoremap <Up> gk
        set virtualedit=block
        set virtualedit?
    endif
endfunction

function! CycleEditDisplay(mode = '')
    if a:mode == 'init'
        let b:CycleEditDisplay_mode = 'default'
    elseif a:mode == '1'
        " This is 'paste'
        let b:CycleEditDisplay_mode = 'none'
    elseif a:mode == '0'
        " This is 'nopaste'
        let b:CycleEditDisplay_mode = 'default'
    elseif exists('b:CycleEditDisplay_mode')
        if b:CycleEditDisplay_mode == 'default'
            let b:CycleEditDisplay_mode = 'full'
        elseif b:CycleEditDisplay_mode == 'full'
            let b:CycleEditDisplay_mode = 'none'
        else
            let b:CycleEditDisplay_mode = 'default'
        endif
    else
        let b:CycleEditDisplay_mode = 'default'
    endif

    if b:CycleEditDisplay_mode == 'full'
        set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
        set   list   number   relativenumber   cursorline showbreak=↪ cursorcolumn
        set colorcolumn=+1,80,100,120
    elseif b:CycleEditDisplay_mode == 'none'
        set listchars=tab:→\ ,nbsp:␣,trail:·,precedes:«,extends:»
        set nolist nonumber norelativenumber nocursorline showbreak=  nocursorcolumn
        set colorcolumn=
    else
        set listchars=tab:→\ ,nbsp:␣,trail:·,precedes:«,extends:»
        set   list   number   relativenumber   cursorline showbreak=↪ nocursorcolumn
        set colorcolumn=+1,80,100,120
    endif
    if a:mode != 'init'
        echo 'b:CycleEditDisplay_mode=' . b:CycleEditDisplay_mode
    endif
endfunction
call CycleEditDisplay('init')
