" after/ftplugin Vim script for markdown
" huyz 2011-05-31

setlocal textwidth=78

" In visual mode, type `\\` to align table
vmap <Leader><BSlash> :EasyAlign*<Bar><Enter>
