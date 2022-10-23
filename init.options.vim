" List of directory names for the swap file
" This is the vim6 default, but we have to overwrite what we have in ~/.exrc
set directory=.,~/tmp,/var/tmp,/tmp

set backupcopy=yes      " Preserve the birth time of files, at least on macOS
set nobackup            " gvim-win32 has it on by default
set autoread            " Reload files changed outside vim
set autochdir           " Automatically change the working directory

""" Display options

set icon                " Let vim modify X11 window icon
set title               " Let vim modify window title
                        " (We don't need to restore--our screen overwrites)
set t_ti= t_te=         " Disable tite
set ruler               " Show the cursor position all the time
set laststatus=2        " Show the status line at all times
set cmdheight=2         " Number of screen lines for the command line
set showcmd             " Display at the bottom right incomplete commands that
                        " are still being typed
set ttyfast             " Connection is fast, so redraw well
set visualbell          " Don't beep
set number              " Show absolute line number at current line
set relativenumber      " Show relative line numbers
set cursorline          " Underline current line
set list                " Display tabs
set linebreak           " Wrap at word boundaries (see 'breakat' option)
set showbreak=↪         " String to put at start of lines that are soft-wrapped

" Define how ':set list' will give visual cues
" Test: [ ] [ ]
" Test: [​] (zero-width)
"set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
set listchars=tab:→\ ,nbsp:␣,trail:·,precedes:«,extends:»


""" Split window options

set splitright          " Add new split window to right of current
set splitbelow          " Add new split window below current
set equalalways         " Make windows same size after new/close split
set winheight=15        " Recommended minimum size of window when switching
                        " to one of the split windows, if possible
set winminheight=0      " We don't need to see any line of non-current split
                        " window

""" Buffer options

set hidden              " Automatically hides buffers when abandoned
                        " without requiring them to be saved
                        " (this is vim's funny name for a feature that should
                        " be on by default for any multi-file editor)

""" Command-line options

set history=1024        " New of lines of command line history
set wildmenu wildmode=longest:full
set shortmess=a         " Use short messages whenever possible

""" Editing options

set nostartofline       " Don't move cursor to beg of line when paging
set nojoinspaces        " Don't insert 2 spaces after [.?!] when hitting J
set backspace=2         " Same as "set backspace=indent,eol,start" after vim 5.4
set nrformats-=octal    " Prevent 07 from being interpreted as octal when incrementing

set expandtab
set tabstop=8           " Overwrites ~/.exrc setting in favor of softtabstop
set softtabstop=4       " Write tabs the way we want them
set shiftround          " Round indent to multiple of 'shiftwidth'

" We want to be able to go everywhere when using visual blocks and when
" in insert mode using the arrow keys--this is great for editing tables.
set virtualedit=block,insert

" Cursor shape in insert mode
"let &t_EI = "\e[2 q"    " steady block
let &t_SI = "\e[6 q"    " steady bar
" 2022-10-18 Doesn't blink in neovim
"let &t_SI = "\e[5 q"    " blinking bar

""" Search options

set incsearch           " Do incremental searching
set smartcase           " Override ignorecase if search contains uppercase

" Search highlighting
set hlsearch            " Hightlight search matches
" In case, we're manually sourcing .vimrc and we had a search going, turn
" off the current search highlight
noh

""" Programming options

"set errorfile=errors
" errorformat: 1) GCC, 2) generic C compilers
set errorformat=%f:%l:\ %m,\"%f\"\\,%*[^0-9]%l:\ %m

" Paths to search for the find commands
set path+=~/include,~/*/include

""" Folding

" 2012-06-24 vim 7.3 seems to have a bug that makes this option slow everything down
"set foldmethod=syntax
" 2022-10-20 We're at vim 9. Let's try it agian
"set foldmethod=manual
set foldmethod=syntax

set foldlevelstart=99
let javaScript_fold    = 1
let perl_fold          = 1
let php_folding        = 1
let r_syntax_folding   = 1
let ruby_fold          = 1
let sh_fold_enabled    = 1
let vimsyn_folding     = 'af'
let xml_syntax_folding = 1

""" Internationalization options

" Avoid VimR issue https://github.com/qvacua/vimr/issues/879
if !has("gui_vimr")
    language messages en_US.UTF-8 " Use English menus at all times
endif

""" Sessions

" Recommended https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
set sessionoptions+=winpos,terminal,folds

""" Misc options

set keywordprg=man            " Command when hitting K: default to man
set mouse=a                   " Enable the mouse where possible. (Great for Tagbar)