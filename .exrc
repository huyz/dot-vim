" ex/vi Initialization File
" CREATED: huyz 1995-05-06
" Sourced (and overridden as appropriate) by ~/.vimrc
"
""" settings
set report=1
set showmode
set showmatch
set nowrapscan
set tabstop=4
set shiftwidth=2
set autoindent
"
""" Main mappings
map \c1 :set ts=2 sw=2
map \c2 :set ts=4 sw=2
map \c3 :set ts=8 sw=4
map \c4 :set ts=8 sw=8
" Allows pasting
map \o5 :set noai noshowmatch
" After pasting, goes back to normal mode
map \o6 :set ai showmatch
map \o1 :set nu
map \o2 :set nonu
map \o9 :set list
map \o0 :set nolist
" Deprecated by vim5's :set ts=2<CR>:retab<CR>
map \t2 :%!expand -i -t 2
" Deprecated by vim5's :set ts=4<CR>:retab<CR>
map \t4 :%!expand -i -t 4
" Deprecated by vim5's :set ts=8<CR>:retab<CR>
map \t8 :%!expand -i -t 8
"
""" Function key mappings
map \f1 \c1
map \f2 \c2
map \f3 \c3
map \f4 \c4
map \f5 \o5
map \f6 \o6
" Overridden in .vimrc in favor of toggling textwidth
map \f7 \o1
" Overridden in .vimrc in favor of virtual editing
map \f8 \o2
map \f9 \o9
map \f0 \o0
map [11~ \f1
map [12~ \f2
map [13~ \f3
map [14~ \f4
map [15~ \f5
map [17~ \f6
map [18~ \f7
map [19~ \f8
map [20~ \f9
map [21~ \f0
map OP \f1
map OQ \f2
map OR \f3
map OS \f4
map Ot \f5
map Ou \f6
map Ov \f7
map Ol \f8
map Ow \f9
map Ox \f0
"
""" Special keyboards mappings
" Putty
map [3~ 
map [5~ 
map [6~ 
map Oy 
map Os 
map [1~ 1G
map [4~ G
