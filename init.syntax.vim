""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Filetype-detection options

" Enable file type detection, as per vimrc_example.vim
" Load indent files, to automatically do language-dependent indenting.
" NOTE: this must be run after loading plugins, to pick up new file types i
" bundle, CoffeeScript
filetype plugin indent on

" When editing a file, always jump to the last known cursor position
" (as saved in the session info found in ~/.viminfo),
" but don't do it when the position is invalid or when inside an event handler
" (this happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \  exe "normal g`\"" |
    \ endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Syntax highlighting

""" Options

let java_highlight_functions = 1

" If defined, enhance with bash syntax (unless overridden by b:is_kornshell)
let is_bash = 1

""" Enable Syntax-highlighting options

if &t_Co > 2 || has("gui_running") " If we have color

    if !has("gui_running")
        " Set background based on our environment variable with a default of light
        " (we default to light because dark colors on white are easier to see
        " than light colors on black)
        if $user_background == "dark"
            set background=dark
        else
            set background=light
        endif
    endif

    " Turn on syntax highlighting
    syntax on

else " If we don't have color
    " Highlighting for monochrome screens (with underlines and crap) sucks
    syntax off
endif

