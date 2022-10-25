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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Source other files {{{1

""" Load up any custom initializations before this file
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

""" Splitting .vimrc into smaller files

source $MYVIM/init.options.vim
source $MYVIM/init.plugins.vim
source $MYVIM/init.plugins-coc.vim
source $MYVIM/init.display-modes.vim
source $MYVIM/init.mappings-emulation.vim
source $MYVIM/init.mappings-custom.vim
source $MYVIM/init.operations.vim
source $MYVIM/init.abbreviations.vim
source $MYVIM/init.terminal.vim
source $MYVIM/init.syntax.vim
source $MYVIM/init.color.vim
source $MYVIM/init.syntax-overrides.vim
source $MYVIM/init.neovim.vim

""" Option overrides

" For proteges (users who symlink to my files)
if isdirectory(expand("$MEHOME/.vim"))
    set runtimepath^=$MEHOME/.vim
    if isdirectory(expand("$MEHOME/.vim/after"))
        set runtimepath+=$MEHOME/.vim/after
    endif
endif

""" Load up any custom initializations after this file

if filereadable(expand("$MYVIM/.vimrc.post"))
    source $MYVIM/.vimrc.post
endif

" vim:set ai et sts=2 sw=2 tw=0:
