"
" Created:  huyz 1995-05-06
" Requires: vim 8 and later

" NOTE:
" - Our mapping convention: <Leader> is '\' in normal and '\`' in insert mode:
"   (backtick was chosen because it can be easily typed by left hand right after backslash)
"   e.g. \[a-z] mappings are ok in normal mode, but use \`[a-z] for insert mode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Init {{{1

""" Find .vim/ relative to .vimrc
" Usage: vim -u /path/to/portable/vim/.vimrc

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

""" Use Vim defaults (vs. vi)
" NOTE: This must be first, because it changes other options as a side effect.
"
set nocompatible

""" Neovide: Set g:gui_running

if has('gui_running') || exists('g:neovide')
    let g:gui_running = 1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Source other files {{{1

""" Load up any custom initializations before this file
if filereadable(expand("$MYVIM/.vimrc.pre"))
    source $MYVIM/.vimrc.pre
endif

""" Standard vi settings are shared with vi in ~/.exrc

if filereadable(expand("$MYVIM/.exrc"))
    source $MYVIM/.exrc
elseif filereadable(expand("~/.exrc"))
    source ~/.exrc
endif

""" Choose between coc or mason

"let g:coc_or_mason = 'mason'
let g:coc_or_mason = 'coc'

""" Splitting .vimrc into smaller files

source $MYVIM/init.util.vim
source $MYVIM/init.options.vim
source $MYVIM/init.plugins.vim
if g:coc_or_mason == 'coc' && (has("nvim") || v:version >= 801)
    source $MYVIM/init.plugins-coc.vim
endif
source $MYVIM/init.display-modes.vim
source $MYVIM/init.mappings-aliases.vim
source $MYVIM/init.mappings-emulation.vim
source $MYVIM/init.mappings-custom.vim
source $MYVIM/init.operations.vim
source $MYVIM/init.abbreviations.vim
source $MYVIM/init.terminal.vim
source $MYVIM/init.syntax.vim
source $MYVIM/init.color.vim
source $MYVIM/init.syntax-overrides.vim
source $MYVIM/init.neovim.vim

""" Load up any custom initializations after this file

if filereadable(expand("$MYVIM/.vimrc.post"))
    source $MYVIM/.vimrc.post
endif

""" neovide doesn't load up .gvimrc for some reason
if exists('g:neovide')
    source $MYVIM/.gvimrc
endif


" vim:set ai et sts=4 sw=4 tw=98:
