#!/bin/sh
# huyz 2011-07-03
# Outputs $VIMRUNTIME
# http://vim.wikia.com/wiki/Find_VIMRUNTIME_in_a_bash_script

vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015'
