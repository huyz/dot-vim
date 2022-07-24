"
" Created:  huyz 1995-05-06
" Requires: vim 7 and later

" NOTE:
" - Our mapping convention: <Leader> is '\' in normal and '\`' in insert mode:
"   (backtick was chosen because it can be easily typed by left hand right after backslash)
"   e.g. \[a-z] mappings are ok in normal mode, but use \`[a-z] for insert mode
" - $MEHOME is an envar set so that users who symlink to my files can
"   automatically load some of my settings.  Just ignore it.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Allow ~/.vim to be anywhere (based on location of .vimrc)
""" To enable, invoke: vim -u /path/to/portable/vim/.vimrc

" what is the name of the directory containing this file?
let $MYVIM = expand('<sfile>:p:h')

" If .vimrc is from ~, then we assume ~/.vim as usual
if $MYVIM == $HOME
  let $MYVIM = expand("$HOME/.vim")
else
  " set default 'runtimepath' (without ~/.vim folders)
  let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

  " add the directory to 'runtimepath'
  let &runtimepath = printf('%s,%s,%s/after', $MYVIM, &runtimepath, $MYVIM)
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather then Vi settings (much better!).
" NOTE: This must be first, because it changes other options as a side effect.
set nocompatible

" Load up any custom initializations before this file
if filereadable(expand("$MYVIM/.vimrc.pre"))
  source $MYVIM/.vimrc.pre
endif

""" Standard vi settings are shared with vi in ~/.exrc

if filereadable(expand("$MEHOME/.exrc"))
  source $MEHOME/.exrc
elseif filereadable(expand("$MYVIM/.exrc"))
  source $MYVIM/.exrc
elseif filereadable(expand("~/.exrc"))
  source ~/.exrc
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Copy neovim's default mappings

nnoremap Y y$
nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
xnoremap * y/\V<C-R>"<CR>
xnoremap # y?\V<C-R>"<CR>
nnoremap & :&&<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Key Mappings

""" Movement mappings

nnoremap <Home> 1G
nnoremap <End> G

" Use arrows to navigate wrapped lines
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj
" Handle wrapped lines more intuitively by reversing meaning
" (Use arrow keys for old behavior)
"nnoremap k gk
"nnoremap j gj
"nnoremap gk k
"nnoremap gj j
"nnoremap 0 g0
"nnoremap ^ g^
"nnoremap $ g$
"nnoremap g0 0
"nnoremap g^ ^
"nnoremap g$ $

" Closes buffer without messing up split window
" (goes to the next buffer first so that the split window is not closed)
nnoremap <C-w><C-q> :bnext<CR>:bdel #<CR>

" Move between split windows
" FIXME: we need S-Left and S-Right to override vim-visual-multi easily
nnoremap <S-Left> <C-w>h
nnoremap <S-Down> <C-w>j
nnoremap <S-Up> <C-w>k
nnoremap <S-Right> <C-w>l
tnoremap <S-Left> <C-\><C-N><C-w>h
tnoremap <S-Down> <C-\><C-N><C-w>j
tnoremap <S-Up> <C-\><C-N><C-w>k
tnoremap <S-Right> <C-\><C-N><C-w>l

""" Emacs mappings (and also to replace the useless and dangerous ^A and ^X)

" File operations
nnoremap <C-x><C-s> :w<CR>
nnoremap <C-x><C-f> :e
inoremap <C-x><C-s> <C-o>:w<CR>
nnoremap <C-a> 0

" Window operations
nnoremap <C-x>2 <C-w>s
nnoremap <C-x>3 <C-w>v
nnoremap <C-x>0 <C-w>c
nnoremap <C-x>1 <C-w>o
nnoremap <C-x>o <C-w>w
nnoremap <C-x>+ <C-w>=

" Command-line
cnoremap <C-g> <C-c>

""" Paragraph formatting mappings (and to override annoying default mappings)

" Emulate emacs, saving the cursor position
nnoremap <Esc>q m`gqip``
" FIXME: can't get this to work -- cursor position is wrong at end of line
"inoremap <Esc>q <C-o>m`<C-o>gqip<C-o>``

" Use Q for par formating
" NOTE: regular formatting is still done with gq
vnoremap Q !par -w<CR>

""" Misc mappings

" Remove search highlight (same mapping as "less") but neovim's `<C-l>` is better
nnoremap <Esc>u :noh<CR>

" Folding http://vim.wikia.com/wiki/Folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" Suspend from insert mode
noremap! <C-z> <Esc><C-z>
" Quick-save
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>
" Edits .vimrc
nnoremap <Leader>vi :e $MYVIM/.vimrc<CR>
" Re-sources .vimrc
nnoremap <Leader>so :so $MYVIM/.vimrc<CR>
" Allow saving of files as sudo when you forget to start vim using sudo.
" Shortcut matches my zsh binding
cnoremap <C-x><C-s> w !sudo tee > /dev/null %

" Indents blocks
"nmap <Tab> >>
"nmap <S-Tab> <<
"vmap <Tab> >gv
"vmap <S-Tab> <gv

""" Function key mappings (like in .exrc, but more portable)

" Different tab settings
nnoremap <Leader>t1 :set et<CR>:set sts=2 sw=2<CR>
nnoremap <Leader>t2 :set et<CR>:set sts=4 sw=2<CR>
nnoremap <Leader>t3 :set et<CR>:set sts=8 sw=4<CR>
nnoremap <Leader>t4 :set noet<CR>:set sts=8 sw=8<CR>

" Different options
nnoremap <Leader>o0 :set sts=2 sw=2 wrap linebreak showbreak=↪ number relativenumber cursorline nocursorcolumn colorcolumn=+1,80,100,120<CR>
nmap <Leader>o1 :set invpaste<CR>:GitGutterToggle<CR><Leader>o2:set paste?<CR>
nnoremap <Leader>o2 :call ZToggleEditDisplay()<CR>
nnoremap <Leader>o3 :set wrap!<CR>
nnoremap <Leader>o4 :call ZCycleTextwidth()<CR>
nnoremap <Leader>o5 :call ZToggleVirtualEdit()<CR>
"nnoremap <Leader>o6 :!elinks -default-mime-type "text/html" file://%<CR>

" Invoke plugins
nnoremap <Leader>p1 :NERDTreeToggle<CR>
nnoremap <Leader>p2 :FZF<CR>
nnoremap <Leader>p3 :CtrlP<CR>
nnoremap <Leader>p4 :CtrlP .<CR>
nnoremap <Leader>p5 :CtrlPBuffer<CR>
nnoremap <Leader>p6 :LazyGit<CR>
nnoremap <Leader>p7 :SymbolsOutline<CR>

" Current mappings we want quick access to
nmap <Leader>f1 <Leader>p1
nmap <Leader>f2 <Leader>p2
nmap <Leader>f3 <Leader>p3
nmap <Leader>f4 <Leader>p5
nmap <Leader>f5 <Leader>o1
nmap <Leader>f6 <Leader>o2
nmap <Leader>f7 <Leader>o3
nmap <Leader>f8 <Leader>o4
nmap <Leader>f9 <Leader>o5
nmap <Leader>f0 <Leader>p6
nmap <Leader>F1 <Leader>p7
nmap <Leader>F2 <Leader>p5

" Normal function key mappings (these don't change)
nmap <F1> <Leader>f1
nmap <F2> <Leader>f2
nmap <F3> <Leader>f3
nmap <F4> <Leader>f4
nmap <F5> <Leader>f5
nmap <F6> <Leader>f6
nmap <F7> <Leader>f7
nmap <F8> <Leader>f8
nmap <F9> <Leader>f9
nmap <F10> <Leader>f0
nmap <F11> <Leader>F1
nmap <F12> <Leader>F2

"nmap <C-Q>1 <Leader>s1
"nmap <C-Q>2 <Leader>s2
"nmap <C-Q>3 <Leader>s3

" Make pastetoggle also work in insert mode
set pastetoggle=<f5>

""" Command+number mappings

if has("gui_running")
  " Switch tab with Cmd +[1-9].
  " NOTE: can't do <c-2> and <c-6> for some reason so we rely on <d-2>
  nnoremap <d-1> :tabn 1<CR>
  nnoremap <d-2> :tabn 2<CR>
  nnoremap <d-3> :tabn 3<CR>
  nnoremap <d-4> :tabn 4<CR>
  nnoremap <d-5> :tabn 5<CR>
  nnoremap <d-6> :tabn 6<CR>
  nnoremap <d-7> :tabn 7<CR>
  nnoremap <d-8> :tabn 8<CR>
  nnoremap <d-9> :tabn 9<CR>
  nnoremap <d-9> :tabn 0<CR>
  inoremap <d-1> <C-o>:tabn 1<CR>
  inoremap <d-2> <C-o>:tabn 2<CR>
  inoremap <d-3> <C-o>:tabn 3<CR>
  inoremap <d-4> <C-o>:tabn 4<CR>
  inoremap <d-5> <C-o>:tabn 5<CR>
  inoremap <d-6> <C-o>:tabn 6<CR>
  inoremap <d-7> <C-o>:tabn 7<CR>
  inoremap <d-8> <C-o>:tabn 8<CR>
  inoremap <d-9> <C-o>:tabn 9<CR>
  inoremap <d-9> <C-o>:tabn 0<CR>
endif


""" Keyboard mappings (To teach vim some new keymaps)

" Putty keymap
nnoremap <Esc>OA <Up>
nnoremap <Esc>OB <Down>
nnoremap <ESC>[Z <S-Tab>
inoremap <Esc>OA <Up>
inoremap <Esc>OB <Down>
inoremap <ESC>[Z <S-Tab>
vnoremap <Esc>OA <Up>
vnoremap <Esc>OB <Down>
vnoremap <ESC>[Z <S-Tab>

""" Support functions for complex mappings

" Cycle textwidth
function! ZCycleTextwidth()
  if &textwidth == 0
    set textwidth=78
  elseif &textwidth == 78
    set textwidth=98
  else
    set textwidth=0
  endif
  echo "textwidth=" . &textwidth
endfunction

" Toggle virtual movement, which is useful for editing tables
" By default, we have "block,insert" set
function! ZToggleVirtualEdit()
  if &virtualedit == "block,insert"
    nnoremap r gr
    nnoremap R gR
    " 2011-05-26 Now, we've already reversed the meanings of j and k, by default
    "nnoremap k gk
    "nnoremap j gj
    set virtualedit=all
    set virtualedit?
  else
    nunmap r
    nunmap R
    "nunmap k
    "nunmap j
    set virtualedit=block,insert
    set virtualedit?
  endif
endfunction

" Cycle different editing aids
function! ZToggleEditDisplay()
  if &list || &number ||  &relativenumber || &cursorline || &showbreak || &cursorcolumn
    set nolist nonumber norelativenumber nocursorline showbreak=  nocursorcolumn
  else
    set   list   number   relativenumber   cursorline showbreak=↪
  endif
endfunction
" XXX Deprecated (too complicated)
function! ZCycleEditDisplay()
  if     !&list && !&number && !&relativenumber
    set number cursorline cursorcolumn
  elseif !&list &&  &number && !&relativenumber
    set relativenumber cursorline cursorcolumn
  elseif !&list &&  &number &&  &relativenumber
    set list
  else
    set nolist nonumber norelativenumber nocursorcolumn nocursorline
  endif
endfunction

""" Typo Corrections

" I hold <shift> too long when typing ':'
" NOTE: we add the ! so we can re-source .vimrc
command! Q q
command! Qa qa
command! QA qa
command! W w

""" Misc Mappings

" Case-insensitive search (doesn't make sense to set 'ignorecase'
" as it's dangerous for substitutions)
" NOTE: \v isn't completely like perl, even with the basics, because
" the charaters <>= are now special that weren't with perl
nnoremap / /\c
nnoremap ? ?\c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Complex mappings

" Select last pasted block
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Swap words
" http://www.vim.org/tips/tip.php?tip_id=329
nmap <Leader>lh <Leader>_do_"_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><Leader>_done_

" Quotes with backticks (useful for Markdown-style code words)
" Like using vim-surround with ysiw`, just quicker
nnoremap <Leader>` ciw`<C-R>-`<Esc>

" Discard consecutive blank lines
nmap <Leader>t0 <Leader>_do_:v/./.,/./-1join<CR><Leader>_done_

" Utility functions for macros below
" (Remembers the last search, removes the `highlight`, and recovers old position)
noremap <Leader>_do_ :let hls=@/<CR>
noremap <Leader>_done_ :let @/=hls<CR>:nohl<CR><C-O>
"
" Halve the indentation of the file, assuming spaces
" NOTE: makes sense only with expandtab on
" TODO: doesn't work on mac
nmap <Leader><TAB>< <Leader>_do_:%!unexpand --first-only -t 2<CR>:%!expand --initial -t 1<CR><Leader>_done_
" Double the indentation of the file, assuming spaces
nmap <Leader><TAB>> <Leader>_do_:%s/^\(\s*\)/\1\1/<CR><Leader>_done_

" Underlines the current line with '~', '-', '=' characters (good for markdown)
nmap <Leader>= <Leader>_do_yyp:s/./=/g<CR><Leader>_done_
nmap <Leader>- <Leader>_do_yyp:s/./-/g<CR><Leader>_done_
nmap <Leader>~ <Leader>_do_yyp:s/./\~/g<CR><Leader>_done_

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Complex abbrevations

" Inserts a row of '*' characters up to the 78th column
inoremap <Leader>`** <Esc>80a*<Esc>78\|C
" Inserts a row of '#' characters up to the 78th column
inoremap <Leader>`## <Esc>80a#<Esc>78\|C
" Inserts a row of '-' characters up to the 78th column
inoremap <Leader>`-- <Esc>80a-<Esc>78\|C
" Inserts a row of '- ' characters up to the 78th column
inoremap <Leader>`-<Space> <Esc>40a- <Esc>78\|C

" Inserts current date at insertion point.
inoremap <Leader>`d <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <Leader>`D <C-R>=strftime("%FT%T%z")<CR>
inoremap <Leader>`t <C-R>=strftime("%T")<CR>
iab CRE: created: <C-R>=$LOGNAME<CR> <Leader>`d<CR>updated: <C-R>=$LOGNAME<CR> <Leader>`d
iab ---: ---<CR>updated: '<Leader>`D'<CR>created: '<Leader>`D'<CR>---

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Options

""" File Options

" For proteges (users who symlink to my files)
if isdirectory(expand("$MEHOME/.vim"))
  set runtimepath^=$MEHOME/.vim
  if isdirectory(expand("$MEHOME/.vim/after"))
    set runtimepath+=$MEHOME/.vim/after
  endif
endif

" List of directory names for the swap file
" This is the vim6 default, but we have to overwrite what we have in ~/.exrc
set directory=.,~/tmp,/var/tmp,/tmp

set backupcopy=yes      " Preserve the birth time of files, at least on macOS
set nobackup            " gvim-win32 has it on by default
set autoread            " Reload files changed outside vim

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
"set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
" Test: [ ] [ ]
set listchars=tab:→\ ,nbsp:␣,trail:·,precedes:«,extends:»
" Test: [​] (zero-width)


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
                        " NOTE: bs=1 doesn't work with vim-multiple-cursors
set nrformats-=octal    " Prevent 07 from being interpreted as octal when incrementing

set expandtab
set tabstop=8           " Overwrites ~/.exrc setting in favor of softtabstop
set softtabstop=4       " Write tabs the way we want them
set shiftround          " Round indent to multiple of 'shiftwidth'

" We want to be able to go everywhere when using visual blocks and when
" in insert mode using the arrow keys--this is great for editing tables.
set virtualedit=block,insert

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
set foldmethod=manual
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins
" NOTE: this must run before `filetype plugin indent on` in order to pick
" up new file types in bundle, CoffeeScript

" Built-in plugins
runtime macros/matchit.vim

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" - Normallly, for Neovim it would be: ~/.local/share/nvim/plugged
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Dependencies
" webapi-vim is required by gist-vim and optional for emmet-vim
Plug 'mattn/webapi-vim'

" Colorscheme
if has("nvim")
  Plug 'cormacrelf/dark-notify'
else
  if has("gui_running")
    Plug 'L-TChen/auto-dark-mode.vim'
  endif
endif
Plug 'chriskempson/base16-vim'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'sjl/gundo.vim'
Plug 'brglng/vim-im-select'

" Files
if has("nvim") && has("gui_running")
  Plug 'rmagatti/auto-session', { 'branch': 'main' }
endif
Plug 'kien/ctrlp.vim'
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Text
Plug 'ap/vim-you-keep-using-that-word'
Plug 'tpope/vim-repeat'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/vim-easy-align'
Plug 'bronson/vim-visual-star-search'
Plug 'dhruvasagar/vim-table-mode'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tommcdo/vim-exchange'
Plug 'Kachyz/vim-gitmoji'

" Text objects
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'kana/vim-textobj-user'  " dependency of textobj-entire
Plug 'kana/vim-textobj-entire'

" Dev
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript', 'jsx', 'typescript', 'xml'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'jsx', 'typescript'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescriptreact' }
if has("nvim")
  Plug 'simrat39/symbols-outline.nvim'
endif
Plug 'kdheepak/lazygit.nvim', {'branch': 'main'}

" External sites
Plug 'mattn/gist-vim'

" Misc
Plug 'dbeniamine/cheat.sh-vim'
Plug 'jamessan/vim-gnupg'
if has("nvim")
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif

" MarkdownPreview
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Initialize plugin system
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Filetype-detection options

" Enable file type detection, as per vimrc_example.vim
if has("autocmd")
  " Load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
endif

if has("autocmd")
  " When editing a file, always jump to the last known cursor position
  " (as saved in the session info found in ~/.viminfo),
  " but don't do it when the position is invalid or when inside an event handler
  " (this happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \  exe "normal g`\"" |
    \ endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Hacks

" WIP Experimental
" Make fileencoding work in modelines
" http://vim.wikia.com/wiki/How_to_make_fileencoding_work_in_the_modeline
"autocmd BufReadPost * let b:reloadcheck = 1
"autocmd BufWinEnter * if exists('b:reloadcheck') | unlet b:reloadcheck | if &mod != 0 && &fenc != "" | exe 'e! ++enc=' . &fenc | endif | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugin options

""" auto-session

let g:auto_session_root_dir = expand("~/.local/share/nvim/sessions")

""" vim-visual-multi

" FIXME: C-LeftMouse doesn't work
"let g:VM_mouse_mappings = 1

""" vim-indent-guides

let g:indent_guides_enable_on_vim_startup = 1

""" CtrlP

let g:ctrlp_cmd = 'CtrlPBuffer'

"set wildignore+=/tmp/,.so,.so p,*.zip
let g:ctrlp_custom_ignore = {
 \ 'dir':  '\v[\/](\.(git|hg|svn)|.venv|venv.*|node_modules)$',
 \ 'file': '\v\.(pyc|class|DS_Store)$',
 \ }

let g:ctrlp_max_files = 20000

""" fzf

set rtp+=~/.fzf

""" Gist

" NOTE: set in .vimrc.post
"let g:github_user  = "YOUR_GITHUB_USERNAME"
"let g:github_token = "YOUR_GITHUB_API_TOKEN"

""" miniBufExpl

" Disable miniBufExpl if in VimR
if has("gui_vimr")
  let g:miniBufExplorerMoreThanOne=99
endif

let g:miniBufExplSplitBelow=0  " Put new window above
                               " current or on the
                               " left for vertical split

""" easymotion

" n-character search
nmap - <Plug>(easymotion-sn)
" visual mode
xmap - <Plug>(easymotion-sn)
" operator-pending-mode, e.g. `d-ea`
" NOTE: `-tn` means the character before the match
omap - <Plug>(easymotion-tn)

" next match
map  _ <Plug>(easymotion-prev)
map  + <Plug>(easymotion-next)

""" CamelCaseMotion

let g:camelcasemotion_key = ','
omap <silent> i<leader>w <Plug>CamelCaseMotion_iw
xmap <silent> i<leader>w <Plug>CamelCaseMotion_iw
omap <silent> i<leader>b <Plug>CamelCaseMotion_ib
xmap <silent> i<leader>b <Plug>CamelCaseMotion_ib
omap <silent> i<leader>e <Plug>CamelCaseMotion_ie
xmap <silent> i<leader>e <Plug>CamelCaseMotion_ie
imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b
imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w

""" vim-easy-align

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap gA <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap gA <Plug>(EasyAlign)

""" NERDtree

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""" NERDcommenter options

map <Leader>c/ <plug>NERDCommenterAlignBoth
"map <Leader>bj <plug>NERDCommenterAlignBoth

""" syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_python_pylint_post_args  = "--max-line-length=100"

" on macOS 10.15.7: system "python" is still python2
let g:syntastic_python_checkers          = ['python3', 'pylint']

""" vim-gnupg

" NOTE: set in .vimrc.post
"let g:GPGDefaultRecipients = [ 'YOUR_GPG_EMAIL' ]

""" vim-gitmoji

set completefunc=emoji#complete
" Replace all :emoji_name: into Unicode emojis
nmap <Leader><C-U> :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>

""" coc.nvim

let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-pyright']
let g:python3_host_prog = expand("~/.pyenv/versions/py3nvim/bin/python")

" Usage: type `:Prettier` to format whole document
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Usage: select range and invoke `\f`
vmap <Leader>f <Plug>(coc-format-selected)
nmap <Leader>f <Plug>(coc-format-selected)

""" Firenvim

if has("nvim")
  let g:firenvim_config = {
        \ 'localSettings': {
          \ 'https?://[^/]+\.slack\.com/': { 'takeover': 'never' }
        \ }
  \ }

  function! RemapCopyAndPaste()
    " Get Copy and Paste working inside the browser
    vnoremap <D-x> "+d
    vnoremap <D-c> "+y
    vnoremap <D-v> "+gP
    nnoremap <D-v> "+gP
    cnoremap <D-v> <C-R>+
    inoremap <D-v> <C-R><C-O>+
  endfunction

  if exists('g:started_by_firenvim')
    set laststatus=0
    call RemapCopyAndPaste()
  endif
  function! OnUIEnter(event) abort
    if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
      set laststatus=0
      call RemapCopyAndPaste()
    endif
  endfunction
  autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Syntax highlighting

""" Options

let java_highlight_functions = 1

" If defined, enhance with bash syntax (unless overridden by b:is_kornshell)
let is_bash = 1

""" Enable Syntax-highlighting options

if &t_Co > 2 || has("gui_running") " If we have color

  " Set background based on our environment variable with a default of light
  " (we default to light because dark colors on white are easier to see
  " than light colors on black)
  if $user_background == "dark"
    set background=dark
  else
    set background=light
  endif

  " Turn on syntax highlighting
  syntax on

else " If we don't have color
  " Highlighting for monochrome screens (with underlines and crap) sucks
  syntax off
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Color schemes
" Usage: `\b` to toggle between dark and light

function! SetBackgroundDark()
  execute 'colorscheme ' . g:colorscheme_dark
  set background=dark

  " NOTE: this needs to be after setting background
  highlight ColorColumn term=reverse ctermbg=darkgrey guibg=grey25
  " For reference: Auto colors by g:indent_guides_auto_colors=1
  "highlight IndentGuidesOdd ctermfg=242 ctermbg=0 guifg=grey15 guibg=grey30
  "highlight IndentGuidesEven ctermfg=0 ctermbg=242 guifg=grey30 guibg=grey15
  " FIXME: can't get guibg to take effect on startup
  highlight IndentGuidesEven guibg=grey23

  " 2021-07-02 On MacVim, can't see the cursor on top of yellow search results.  So tone down the yellow.
  " Don't really have time to make this cleaner
  if has("gui_running")
    highlight Search guifg=#282a2e guibg=#f0c674
  endif
endfunction

function! SetBackgroundLight()
  execute 'colorscheme ' . g:colorscheme_light
  set background=light

  " NOTE: this needs to be after setting background
  highlight ColorColumn term=reverse ctermbg=lightgrey guibg=grey75
  " For reference: Auto colors by g:indent_guides_auto_colors=1
  " Auto colors by g:indent_guides_auto_colors=1
  "highlight IndentGuidesOdd ctermfg=7 ctermbg=15 guifg=grey70 guibg=grey85
  "highlight IndentGuidesEven ctermfg=15 ctermbg=7 guifg=grey85 guibg=grey70
endfunction

function! ToggleBackground()
  if &background == "dark"
    call SetBackgroundLight()
  else
    call SetBackgroundDark()
  endif
endfunction
nnoremap <silent> <Leader>b :call ToggleBackground()<CR>

" Startup
if $TERM_PROGRAM =~ "iTerm" && !exists('$TMUX') && !exists('$STY')
  let g:airline_theme = 'base16_tomorrow'
  set termguicolors
  let g:colorscheme_dark = "base16-tomorrow-night"
  let g:colorscheme_light = "base16-tomorrow"
else
  let g:airline_theme = 'base16_colors'
  if has("gui_vimr")
    " VimR can't seem to understand what "default" combined with bg=light should end up with
    let g:colorscheme_dark = "base16-tomorrow-night"
    let g:colorscheme_light = "base16-tomorrow"
  else
    let g:colorscheme_dark = "default"
    let g:colorscheme_light = "default"
  endif
endif

if &background == 'dark'
  call SetBackgroundDark()
else
  call SetBackgroundLight()
endif

if has("nvim")
  :lua <<EOF
  require('dark_notify').run({
      onchange = function(mode)
          -- optional, you can configure your own things to react to changes.
          -- this is called at startup and every time dark mode is switched,
          -- either via the OS, or because you manually set/toggled the mode.
          -- mode is either "light" or "dark"
          if (mode == "dark")
          then
            vim.api.nvim_call_function("SetBackgroundDark", {})
          else
            vim.api.nvim_call_function("SetBackgroundLight", {})
          end
      end,
  })
EOF
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Syntax highlighting overrides

function! HighlightStrangeWhitespace()
  " Highlight whitespace at end of line
  " (if there's more than one extra one or more than two extra ones in
  " the case of after a dot, so we don't get too much feedback as we type)
  " http://www.vim.org/tips/tip.php?tip_id=396
  " FIXME:
  "   - See improvements at http://vim.wikia.com/wiki/Highlighting_whitespaces_at_end_of_line
  "   - Doesn't work if TERM=xterm-256color
  " Test:
  highlight WhitespaceEOL term=reverse ctermfg=red ctermbg=NONE cterm=underline guifg=red guibg=NONE gui=underline
  " NOTE: lookbehind prevents matching on spaces at beginning of line
  match WhitespaceEOL /\([^.!? \t]\@<=\|[.!?]\s\)\s\s\+$/

  " Highlight Unicode whitespace characters
  " Test: [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [　] [ ] [ ]
  highlight UnicodeWhitespace term=reverse ctermfg=red ctermbg=NONE cterm=underline guifg=red guibg=NONE gui=reverse
  " The list is from https://stackoverflow.com/a/37903645 (with `\t`, `\n`, ` `, `\xa0` removed):
  call matchadd('UnicodeWhitespace', '[\x0b\x0c\r\x1c\x1d\x1e\x1f\x85\u1680\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u2028\u2029\u202f\u205f\u3000]')
endfunction

autocmd BufEnter,WinEnter * call HighlightStrangeWhitespace()


""" Column highlight

if v:version >= 703
  set colorcolumn=+1,80,100,120
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" neovim

""" Language providers

if has("nvim") && has("mac")
  " On macOS, we can't use System perl:
  "   https://stackoverflow.com/questions/52682304/fatal-error-extern-h-file-not-found-while-installing-perl-modules/52997962#52997962
  let g:perl_host_prog = expand("$MYVIM/bin/nvim-perl")
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Terminal

" Usage:
"     <M-Esc>   Go to terminal Normal mode
"   Vim-only:
"     <C-W> .   Send <C-w> to terminal

if has("nvim")
  autocmd TermOpen * setlocal nonumber norelativenumber
else
  autocmd TerminalWinOpen * setlocal nonumber norelativenumber
endif
" Start terminal in insert mode when switching to it
autocmd BufEnter * if &buftype == 'terminal' | set nonumber norelativenumber | :startinsert | endif
" Close terminal buffers if the job exited without error
autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif

" Open terminal with opt+F12 (just like in JetBrains).
function! OpenTerminal()
  if has("nvim")
    split term://zsh
  else
    terminal ++close
  endif
  resize 10
endfunction
nnoremap <m-F12> :call OpenTerminal()<CR>
" In nvim within iTerm, opt+F12 is F60
nnoremap <F60> :call OpenTerminal()<CR>
" In vim within iTerm, opt+F12 is <Esc>[24~
nnoremap <Esc>[24~ :call OpenTerminal()<CR>

if has("nvim")
  tnoremap <D-[> <C-\><C-N>
else
  tnoremap <D-[> <C-w>N
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load up any custom initializations after this file
if filereadable(expand("$MYVIM/.vimrc.post"))
  source $MYVIM/.vimrc.post
endif

" vim:set ai et sts=2 sw=2 tw=0:
