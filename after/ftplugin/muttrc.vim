" after/ftplugin Vim script for mutt
" huyz 2003-11-11

set iskeyword+=",-"

if $LAB == "UGCS"
  " NOTE: We send man through cat to prevent pager
  nnoremap K "1yiw:!(man muttrc \| cat; cat /usr/ug/share/mutt-1.3.28i/doc/mutt/manual.txt) \| less -s "+/  <C-R>1"<CR>
else
  nnoremap K "1yiw:!man -P 'less -s "+/    <C-R>1"' muttrc<CR>
endif
