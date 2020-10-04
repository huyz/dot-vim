" 
" Created:  huyz 1995-05-06
" Requires: vim 7 and later

" NOTE:
" - Our mapping convention: <Leader> is '\' in normal and '\-' in insert mode:
"   e.g. \[a-z] mappings are ok in normal mode, but use \-[a-z] for insert mode
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
""" Command-line commands

" Perl-compatible substitution
" http://vim.wikia.com/wiki/Perl_compatible_regular_expressions
function! s:Substitute(sstring, line1, line2)
    execute a:line1.",".a:line2."!perl -pi -e 'use encoding \"utf8\"; s'".
            \escape(shellescape(a:sstring), '%!').
            \" 2>/dev/null"
endfunction
command! -range -nargs=+ S call s:Substitute(<q-args>, <line1>, <line2>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Misc macros & mappings

" Right after yanking a block, paste and move cursor to end
nnoremap Q ']gpk

" Select last pasted block
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Support for macros
" (Remembers the last search, removes the highlight, and recovers old position)
noremap <Leader>_do_ :let hls=@/<CR>
noremap <Leader>_done_ :let @/=hls<CR>:nohl<CR><C-O>

" Underlines the current line with '~', '-', '=' characters (good for markdown)
map <Leader>~ <Leader>_do_Yp:s/./\~/g<CR><Leader>_done_
map <Leader>- <Leader>_do_Yp:s/./-/g<CR><Leader>_done_
map <Leader>= <Leader>_do_Yp:s/./=/g<CR><Leader>_done_

" Quotes with backticks (useful for Markdown-style code words)
nnoremap <Leader>` ciw`<C-R>-`<Esc>

" Inserts a row of '*' characters up to the 78th column
imap <Leader>-** <Esc>80a*<Esc>78\|C
" Inserts a row of '#' characters up to the 78th column
imap <Leader>-## <Esc>80a#<Esc>78\|C
" Inserts a row of '-' characters up to the 78th column
imap <Leader>-- <Esc>80a-<Esc>78\|C
" Inserts a row of '- ' characters up to the 78th column
imap <Leader>-<Space> <Esc>40a- <Esc>78\|C

" Swap words
" http://www.vim.org/tips/tip.php?tip_id=329
nmap <Leader>lh <Leader>_do_"_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><Leader>_done_

" Discard consecutive blank lines
nmap <Leader>t0 <Leader>_do_:v/./.,/./-1join<CR><Leader>_done_

" Halve the indentation of the file, assuming spaces
" NOTE: makes sense only with expandtab on
" TODO: doesn't work on mac
map <Leader><TAB>< <Leader>_do_:%!unexpand --first-only -t 2<CR>:%!expand --initial -t 1<CR><Leader>_done_
" Double the indentation of the file, assuming spaces
map <Leader><TAB>> <Leader>_do_:%s/^\(\s*\)/\1\1/<CR><Leader>_done_

" Inserts current date at insertion point.
imap <Leader>-d <C-R>=strftime("%Y-%m-%d")<CR>
iab CRE: CREATED: <C-R>=$LOGNAME<CR> <Leader>-d<CR>UPDATED: <C-R>=$LOGNAME<CR> <Leader>-d

""" RCS macros & mappings

inoreab RCSID $RCSfile<C-V>$ $Revision<C-V>$ $Date<C-V>$
nnoremap <Leader>reco :!reco "<C-R>%"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Programming mappings

""" Support mappings for templates.

" Do necessary replacements
map <Leader>_t_s :%s/@User *@/\=$LOGNAME/ge \| %s/@Date *@/\=strftime("%Y-%m-%d")/ge \| %s/@Year *@/\=strftime("%Y")/ge <CR>
map <Leader>_t_z 1G/Filename:<CR>:nohl<CR>A

""" Inserts templates, replaces a few things, and sets file type

imap <Leader>-tt  <Esc>:-1r $MYVIM/templates/header<CR><Leader>_t_s
imap <Leader>-th  <Esc>:-1r $MYVIM/templates/html<CR><Leader>_t_s:setf html<CR>
imap <Leader>-tp  <Esc>:-1r $MYVIM/templates/perl<CR>o<Leader>-tt:setf perl<CR><Leader>_t_z
imap <Leader>-ts0 <Esc>:-1r $MYVIM/templates/script<CR>o<Leader>-tt<Leader>_t_z
imap <Leader>-ts1 <Esc>:-1r $MYVIM/templates/sh1<CR>o<Leader>-tt:setf sh<CR><Leader>_t_z
imap <Leader>-ts2 <Esc>:-1r $MYVIM/templates/sh2<CR>o<Leader>-tt:setf sh<CR><Leader>_t_z
imap <Leader>-tz1 <Esc>:-1r $MYVIM/templates/zsh1<CR>o<Leader>-tt:setf zsh<CR><Leader>_t_z
imap <Leader>-tz2 <Esc>:-1r $MYVIM/templates/zsh2<CR>o<Leader>-tt:setf zsh<CR><Leader>_t_z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Mail mappings (for MH)

""" repl mappings
" Attempts to undo quoting done by replies
map <Leader>> 1G:/^---/+1,$g/^[ ]*[^> ]/-1j:%g/^---/+1,$s/^[ ]*>[ ]\(>[ ]\)*//g<CR>
" Opens the file replied to (Can't rely on MH's @ link because we will
" be in a diff directory because of compeditor or the cwd might not even be
" writable).
map <Leader>e@ :new $editalt<CR>
" Puts in an Fcc based on the current draft
" NOTE: There's gotta be a way to not re-read the whole file so we can set a
" mark
map <Leader>ef :%! getfcc - 2>/dev/null<CR>
" Appends plain-text version of MH HTML body
" (used in conjunction with my repl zsh function that creates this file)
map <Leader>@ Gdd:r ~/tmp/@@<CR>

""" comp/repl/forw mappings
" Invokes buildmimeproc on given email
map <Leader>em :%! `mhparam buildmimeproc` -<CR>
" Quotes lines starting with '#' to differentiate from MIME directives
map <Leader>+# :%s/^#/##/<CR>
" Inserts an example "type" directive for reference.
" After typing this macro, you should be able to type the real name, then
" hit ',' and then hit '.'.  This will change both 'x's quickly.
imap <Leader>-#a #application/octet-stream; name="x_exe" [] x_exe<Esc>F#fxcw
imap <Leader>-#g #image/gif; name="x.gif" [] x.gif<Esc>F#fxs
imap <Leader>-#j #image/jpg; name="x.jpg" [] x.jpg<Esc>F#fxs
imap <Leader>-#m #video/mpeg; name="x.mpg" [] x.mpg<Esc>F#fxs

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Key Mappings

""" Movement mappings

nnoremap <Home> 1G
nnoremap <End> G

" Use arrows to navigate wrapped lines
nnoremap <Up> gk
nnoremap <Down> gj
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

""" Paragraph formatting mappings (and to override annoying default mappings)

" Emulate emacs, saving the cursor position
nnoremap <Esc>q m`gqip``
" FIXME: can't get this to work -- cursor position is wrong at end of line
"inoremap <Esc>q <C-o>m`<C-o>gqip<C-o>``

" Use Q for par formating
" NOTE: regular formatting is still done with gq
vnoremap Q !par -w<CR>

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

""" General mappings

" Case-insensitive search (doesn't make sense to set 'ignorecase'
" as it's dangerous for substitutions)
" NOTE: \v isn't completely like perl, even with the basics, because
" the charaters <>= would be considered special
" NOTE: set in .vimrc.post because this may confuser users
"nnoremap / /\c
"nnoremap ? ?\c

" Folding http://vim.wikia.com/wiki/Folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" Move faster between split windows
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

" Closes buffer without messing up split window
" (goes to the next buffer first so that the split window is not closed)
nnoremap <C-w><C-q> :bnext<CR>:bdel #<CR>

" Suspend from insert mode
noremap! <C-z> <Esc><C-z>
" Quick-save
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>
" Edits .vimrc
nnoremap <Leader>vi :e $MYVIM/.vimrc<CR>
" Re-sources .vimrc
nnoremap <Leader>so :so $MYVIM/.vimrc<CR>

" Indents blocks
"nmap <Tab> >>
"nmap <S-Tab> <<
"vmap <Tab> >gv
"vmap <S-Tab> <gv

""" Function key mappings (like in .exrc, but more portable)

" Different tab settings
nmap <Leader>t1 :set et<CR>:set sts=2 sw=2<CR>
nmap <Leader>t2 :set et<CR>:set sts=4 sw=2<CR>
nmap <Leader>t3 :set et<CR>:set sts=8 sw=4<CR>
nmap <Leader>t4 :set noet<CR>:set sts=8 sw=8<CR>

" Different options
nmap <Leader>o0 :set sw=2 sts=2 wrap linebreak showbreak=… number relativenumber cursorcolumn cursorline colorcolumn=+1,80,100,120<CR>
nmap <Leader>o1 :set invpaste<CR>:GitGutterToggle<CR>:set paste?<CR>
nmap <Leader>o2 :call ZCycleWrap()<CR>
nmap <Leader>o3 :call ZCycleTextwidth()<CR>
nmap <Leader>o4 :call ZToggleVirtualEdit()<CR>
nmap <Leader>o5 :call ZCycleEditDisplay()<CR>
"nmap <Leader>o6 :!elinks -default-mime-type "text/html" file://%<CR>

" Invoke plugins
nmap <Leader>p1 :CtrlPBuffer<CR>
nmap <Leader>p2 :CtrlP<CR>
nmap <Leader>p3 :CtrlP .<CR>
nmap <Leader>p4 :FZF<CR>
nmap <Leader>p5 :NERDTreeToggle<CR>
nmap <Leader>p0 :BufExplorer<CR>

" Current mappings we want quick access to
nmap <Leader>f1 <Leader>t1
nmap <Leader>f2 <Leader>t2
nmap <Leader>f3 <Leader>t3
nmap <Leader>f4 <Leader>o0
nmap <Leader>f5 <Leader>o1
nmap <Leader>f6 <Leader>o2
nmap <Leader>f7 <Leader>o3
nmap <Leader>f8 <Leader>o4
nmap <Leader>f9 <Leader>o5
nmap <Leader>f0 <Leader>p2
nmap <Leader>F1 <Leader>p4
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

""" Keyboard mappings (To teach vim some new keymaps)

" Putty keymap
nmap <Esc>OA <Up>
nmap <Esc>OB <Down>
nmap <ESC>[Z <S-Tab>
imap <Esc>OA <Up>
imap <Esc>OB <Down>
imap <ESC>[Z <S-Tab>
vmap <Esc>OA <Up>
vmap <Esc>OB <Down>
vmap <ESC>[Z <S-Tab>

""" Support functions for key mappings

" Cycle between 3 modes:
" 1) wrap, no showbreak [default]
" 2) wrap, showbreak, linebreak
" 3) nowrap, showbreak, linebreak
" linebreak : Don't break words when visually wrapping
" showbreak : left-fringe indicator
function! ZCycleWrap()
  if &wrap && &showbreak == ""
    set wrap linebreak showbreak=…
    echo "  wrap   linebreak showbreak=…"
  elseif &wrap && &showbreak != ""
    set nowrap nolinebreak showbreak=
    echo "nowrap nolinebreak showbreak="
  else
    set wrap nolinebreak showbreak=
    echo "  wrap nolinebreak showbreak="
  endif
endfunction

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
function! ZCycleEditDisplay()
  " Let's simplify this:
  " if     !&list && !&number && !&relativenumber && !&cursorcolumn
  "   set number
  " elseif !&list &&  &number && !&relativenumber && !&cursorcolumn
  "   set relativenumber
  " elseif !&list &&  &number &&  &relativenumber && !&cursorcolumn
  "   set cursorcolumn cursorline
  " elseif !&list &&  &number &&  &relativenumber &&  &cursorcolumn
  "   set list
  " else
  "   set nolist nonumber norelativenumber nocursorcolumn nocursorline
  " endif
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

""" Mappings

" Case-insensitive search (doesn't make sense to set 'ignorecase'
" as it's dangerous for substitutions)
" NOTE: \v isn't completely like perl, even with the basics, because
" the charaters <>= are now special that weren't with perl
nnoremap / /\c
nnoremap ? ?\c

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

set nobackup            " gvim-win32 has it on by default
set autoread            " Reload files changed outside vim

""" Display options

set icon                " Let vim modify X11 window icon
set title               " Let vim modify window title
                        " (We don't need to restore--our screen overwrites)
set t_ti= t_te=         " Disable tite
set ruler               " Show the cursor position all the time
set laststatus=2        " Show the status line at all times
set showcmd             " Display at the bottom right incomplete commands that
                        " are still being typed
set ttyfast             " Connection is fast, so redraw well
set visualbell          " Don't beep

" Define how ':set list' will give visual cues
set listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>


""" Split window options

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
" Remove search highlight (same mapping as "less")
map <Esc>u :noh<CR>

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

language messages en_US.UTF-8 " Use English menus at all times

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
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Dependencies
" webapi-vim is required by gist-vim and optional for emmet-vim
Plug 'mattn/webapi-vim'

" Colorscheme
if has("gui_running")
  Plug 'L-TChen/auto-dark-mode.vim'
endif
Plug 'chriskempson/base16-vim'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
" 2019-08-18 Has an annoying sizing bug and is no longer maintained
"Plug 'fholgado/minibufexpl.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sjl/gundo.vim'

" Files
Plug 'kien/ctrlp.vim'
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Text
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/vim-easy-align'
Plug 'dhruvasagar/vim-table-mode'

" Dev
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript', 'jsx', 'typescript', 'xml'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'jsx', 'typescript'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" External sites
Plug 'mattn/gist-vim'

" Misc
Plug 'jamessan/vim-gnupg'

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

" XXX Experimental
" Make fileencoding work in modelines
" http://vim.wikia.com/wiki/How_to_make_fileencoding_work_in_the_modeline
"au BufReadPost * let b:reloadcheck = 1
"au BufWinEnter * if exists('b:reloadcheck') | unlet b:reloadcheck | if &mod != 0 && &fenc != "" | exe 'e! ++enc=' . &fenc | endif | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugin options

""" vim-indent-guides

let g:indent_guides_enable_on_vim_startup = 1

""" BufExplorer

let g:bufExplorerSortBy='fullpath'   " Sort by full file path name.

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

""" sneak

let g:sneak#label = 1

""" CamelCaseMotion

let g:camelcasemotion_key = ','

""" vim-easy-align

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

""" vim-gnupg

" NOTE: set in .vimrc.post
"let g:GPGDefaultRecipients = [ 'YOUR_GPG_EMAIL' ]

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
  let g:colorscheme_dark = "default"
  let g:colorscheme_light = "default"
endif

if &background == 'dark'
  call SetBackgroundDark()
else
  call SetBackgroundLight()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Syntax highlighting overrides

" Highlight whitespace at end of line
" (if there's more than one extra one or more than two extra ones in
" the case of after a dot, so we don't get too much feedback as we type)
" http://www.vim.org/tips/tip.php?tip_id=396
" FIXME:
"   - See improvements at http://vim.wikia.com/wiki/Highlighting_whitespaces_at_end_of_line
"   - Doesn't work if TERM=xterm-256color
" Test:  
function! HighlightWhitespaceEOL()
  highlight WhitespaceEOL term=reverse ctermfg=red ctermbg=NONE cterm=underline guifg=red guibg=NONE gui=underline
  " NOTE: lookbehind prevents matching on spaces at beginning of line
  match WhitespaceEOL /\([^.!? \t]\@<=\|[.!?]\s\)\s\s\+$/
endfunction
call HighlightWhitespaceEOL()


""" Column highlight

if v:version >= 703
  set colorcolumn=+1,80,100,120
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load up any custom initializations after this file
if filereadable(expand("$MYVIM/.vimrc.post"))
  source $MYVIM/.vimrc.post
endif

" vim:set ai et sts=2 sw=2 tw=0:
