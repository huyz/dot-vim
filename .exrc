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
" xterm function keys
" Source: https://invisible-island.net/xterm/xterm-function-keys.html
map OP     \f1
map OQ     \f2
map OR     \f3
map OS     \f4
map [15~   \f5
map [17~   \f6
map [18~   \f7
map [19~   \f8
map [20~   \f9
map [21~   \f0
map [23~   \F11
map [24~   \F12
" ftp://www.x.org/pub/X11R6.8.0/PDF/ctlseqs.pdf
"   2: (0001) Shift
"   3: (0010) Alt
"   4: (0011) Shift+Alt
"   5: (0100) Control
"   6: (0101) Shift+Control
"   7: (0110) Alt+Control
"   8: (0111) Shift+Alt+Control
"   9-16: Meta + the above modifiers
" F13 is equivalent to Shift+F1, hence the '2'
map [1;2P  \F13
map [1;2Q  \F14
map [1;2R  \F15
map [1;2S  \F16
map [15;2~ \F17
map [17;2~ \F18
map [18;2~ \F19
map [19;2~ \F20
map [20;2~ \F21
map [21;2~ \F22
map [23;2~ \F23
map [24;2~ \F24
" F25 is equivalent to Ctrl+F1, hence the '5'
map [1;5P  \F25
map [1;5Q  \F26
map [1;5R  \F27
map [1;5S  \F28
map [15;5~ \F29
map [17;5~ \F30
map [18;5~ \F31
map [19;5~ \F32
map [20;5~ \F33
map [21;5~ \F34
map [23;5~ \F35
map [24;5~ \F36
" F37 is equivalent to Shift+Ctrl+F1, hence the '6'
map [1;6P  \F37
map [1;6Q  \F38
map [1;6R  \F39
map [1;6S  \F40
map [15;6~ \F41
map [17;6~ \F42
map [18;6~ \F43
map [19;6~ \F44
map [20;6~ \F45
map [21;6~ \F46
map [23;6~ \F47
map [24;6~ \F48
" F49 is equivalent to Alt+F1, hence the '3'
map [1;3P  \F49
map [1;3Q  \F50
map [1;3R  \F51
map [1;3S  \F52
map [15;3~ \F53
map [17;3~ \F54
map [18;3~ \F55
map [19;3~ \F56
map [20;3~ \F57
map [21;3~ \F58
map [23;3~ \F59
map [24;3~ \F60
"
" F1-F4: xterm-r5, xterm-r6, rxvt
map [11~ \f1
map [12~ \f2
map [13~ \f3
map [14~ \f4
" 2022-11-03: Don't remember where these F5-F10 come from
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
