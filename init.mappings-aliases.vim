""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" macOS: make composed keys act like Meta {{{1

" TODO: to have macmeta working, I'd need to MapAlias a whole different
"   set of accented characters.

" NOTE: Won't remap –, —, ≠, ±, …  as these are useful special characters even to
"   Americans
" NOTE: Can't remap `, e, u, i, n as these are useful to compose digraph prefixes
call MapAlias('å', '<M-a>')
call MapAlias('Å', '<M-A>')
call MapAlias('∫', '<M-b>')
call MapAlias('ı', '<M-B>')
call MapAlias('ç', '<M-c>')
call MapAlias('Ç', '<M-C>')
call MapAlias('∂', '<M-d>')
call MapAlias('Î', '<M-D>')
call MapAlias('ƒ', '<M-f>')
call MapAlias('´', '<M-E>')
call MapAlias('Ï', '<M-F>')
call MapAlias('©', '<M-g>')
call MapAlias('˝', '<M-G>')
call MapAlias('˙', '<M-h>')
call MapAlias('Ó', '<M-H>')
call MapAlias('ˆ', '<M-I>')
call MapAlias('∆', '<M-j>')
call MapAlias('Ô', '<M-J>')
call MapAlias('˚', '<M-k>')
call MapAlias('', '<M-K>')
call MapAlias('¬', '<M-l>')
call MapAlias('Ò', '<M-L>')
call MapAlias('µ', '<M-m>')
call MapAlias('Â', '<M-M>')
call MapAlias('˜', '<M-N>')
call MapAlias('ø', '<M-o>')
call MapAlias('Ø', '<M-O>')
call MapAlias('π', '<M-p>')
call MapAlias('∏', '<M-P>')
call MapAlias('œ', '<M-q>')
call MapAlias('Œ', '<M-Q>')
call MapAlias('®', '<M-r>')
call MapAlias('‰', '<M-R>')
call MapAlias('ß', '<M-s>')
call MapAlias('Í', '<M-S>')
call MapAlias('†', '<M-t>')
call MapAlias('ˇ', '<M-T>')
call MapAlias('¨', '<M-U>')
call MapAlias('√', '<M-v>')
call MapAlias('◊', '<M-V>')
call MapAlias('∑', '<M-w>')
call MapAlias('„', '<M-W>')
call MapAlias('≈', '<M-x>')
call MapAlias('˛', '<M-X>')
call MapAlias('¥', '<M-y>')
call MapAlias('Á', '<M-Y>')
call MapAlias('Ω', '<M-z>')
call MapAlias('¸', '<M-Z>')
call MapAlias('¡', '<M-1>')
call MapAlias('⁄', '<M-!>')
call MapAlias('™', '<M-2>')
call MapAlias('€', '<M-@>')
call MapAlias('£', '<M-3>')
call MapAlias('‹', '<M-#>')
call MapAlias('¢', '<M-4>')
call MapAlias('›', '<M-$>')
call MapAlias('∞', '<M-5>')
call MapAlias('ﬁ', '<M-%>')
call MapAlias('§', '<M-6>')
call MapAlias('ﬂ', '<M-^>')
call MapAlias('¶', '<M-7>')
call MapAlias('‡', '<M-&>')
call MapAlias('•', '<M-8>')
call MapAlias('°', '<M-*>')
call MapAlias('ª', '<M-9>')
call MapAlias('·', '<M-(>')
call MapAlias('º', '<M-0>')
call MapAlias('‚', '<M-)>')
call MapAlias('“', '<M-[>')
call MapAlias('”', '<M-{>')
call MapAlias('‘', '<M-]>')
call MapAlias('’', '<M-}>')
call MapAlias('«', '<M-Bslash>')
call MapAlias('»', '<M-Bar>')
call MapAlias("æ", "<M-'>")
call MapAlias('Ú', '<M-:>')
call MapAlias('æ', "<M-'>")
call MapAlias('Æ', '<M-">')
call MapAlias('≤', '<M-,>')
call MapAlias('¯', '<M-lt>')
call MapAlias('≥', '<M-.>')
call MapAlias('˘', '<M->>')
call MapAlias('¿', '<M-?>')
call MapAlias('÷', '<M-/>')

" TODO: automate these MapAlias whenever they're used
"   instead of mapping them ahead of time.
call MapAlias('ßß', '<M-s><M-s>')
call MapAlias('µµ', '<M-m><M-m>')
call MapAlias('µπ', '<M-m><M-p>')
"call MapAlias('µ¬', '<M-m><M-l>')

call MapAlias('<D-”>', '<M-S-D-{>')
call MapAlias('<D-’>', '<M-S-D-}>')
call MapAlias('<D-±>', '<M-S-D-BS>')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Function key aliases

if !has('gui_running') && has("nvim")
    call MapAlias('<F13>', '<S-F1>')
    call MapAlias('<F14>', '<S-F2>')
    call MapAlias('<F15>', '<S-F3>')
    call MapAlias('<F16>', '<S-F5>')
    call MapAlias('<F17>', '<S-F5>')
    call MapAlias('<F18>', '<S-F6>')
    call MapAlias('<F19>', '<S-F7>')
    call MapAlias('<F20>', '<S-F8>')
    call MapAlias('<F21>', '<S-F9>')
    call MapAlias('<F22>', '<S-F10>')
    call MapAlias('<F23>', '<S-F11>')
    call MapAlias('<F24>', '<S-F12>')
    call MapAlias('<F25>', '<C-F1>')
    call MapAlias('<F26>', '<C-F2>')
    call MapAlias('<F27>', '<C-F3>')
    call MapAlias('<F28>', '<C-F5>')
    call MapAlias('<F29>', '<C-F5>')
    call MapAlias('<F30>', '<C-F6>')
    call MapAlias('<F31>', '<C-F7>')
    call MapAlias('<F32>', '<C-F8>')
    call MapAlias('<F33>', '<C-F9>')
    call MapAlias('<F34>', '<C-F10>')
    call MapAlias('<F35>', '<C-F11>')
    call MapAlias('<F36>', '<C-F12>')
    call MapAlias('<F37>', '<C-S-F1>')
    call MapAlias('<F38>', '<C-S-F2>')
    call MapAlias('<F39>', '<C-S-F3>')
    call MapAlias('<F40>', '<C-S-F5>')
    call MapAlias('<F41>', '<C-S-F5>')
    call MapAlias('<F42>', '<C-S-F6>')
    call MapAlias('<F43>', '<C-S-F7>')
    call MapAlias('<F44>', '<C-S-F8>')
    call MapAlias('<F45>', '<C-S-F9>')
    call MapAlias('<F46>', '<C-S-F10>')
    call MapAlias('<F47>', '<C-S-F11>')
    call MapAlias('<F48>', '<C-S-F12>')
    call MapAlias('<F49>', '<M-F1>')
    call MapAlias('<F50>', '<M-F2>')
    call MapAlias('<F51>', '<M-F3>')
    call MapAlias('<F52>', '<M-F5>')
    call MapAlias('<F53>', '<M-F5>')
    call MapAlias('<F54>', '<M-F6>')
    call MapAlias('<F55>', '<M-F7>')
    call MapAlias('<F56>', '<M-F8>')
    call MapAlias('<F57>', '<M-F9>')
    call MapAlias('<F58>', '<M-F10>')
    call MapAlias('<F59>', '<M-F11>')
    call MapAlias('<F60>', '<M-F12>')
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Function key fallbacks

" Aliases if function keys don't get passed through by the terminal
" NOTE: these are referenced in .exrc but can be used manually just in case
"   and a terminal doesn't have all escape control sequences set up for function
"   keys with modifiers.
nmap <Leader>f1 <F1>
nmap <Leader>f2 <F2>
nmap <Leader>f3 <F3>
nmap <Leader>f4 <F4>
nmap <Leader>f5 <F5>
nmap <Leader>f6 <F6>
nmap <Leader>f7 <F7>
nmap <Leader>f8 <F8>
nmap <Leader>f9 <F9>
nmap <Leader>f0 <F10>
nmap <Leader>F11 <F11>
nmap <Leader>F12 <F12>
nmap <Leader>F13 <S-F1>
nmap <Leader>F14 <S-F2>
nmap <Leader>F15 <S-F3>
nmap <Leader>F16 <S-F5>
nmap <Leader>F17 <S-F5>
nmap <Leader>F18 <S-F6>
nmap <Leader>F19 <S-F7>
nmap <Leader>F20 <S-F8>
nmap <Leader>F21 <S-F9>
nmap <Leader>F22 <S-F10>
nmap <Leader>F23 <S-F11>
nmap <Leader>F24 <S-F12>
nmap <Leader>F25 <C-F1>
nmap <Leader>F26 <C-F2>
nmap <Leader>F27 <C-F3>
nmap <Leader>F28 <C-F5>
nmap <Leader>F29 <C-F5>
nmap <Leader>F30 <C-F6>
nmap <Leader>F31 <C-F7>
nmap <Leader>F32 <C-F8>
nmap <Leader>F33 <C-F9>
nmap <Leader>F34 <C-F10>
nmap <Leader>F35 <C-F11>
nmap <Leader>F36 <C-F12>
nmap <Leader>F37 <C-S-F1>
nmap <Leader>F38 <C-S-F2>
nmap <Leader>F39 <C-S-F3>
nmap <Leader>F40 <C-S-F5>
nmap <Leader>F41 <C-S-F5>
nmap <Leader>F42 <C-S-F6>
nmap <Leader>F43 <C-S-F7>
nmap <Leader>F44 <C-S-F8>
nmap <Leader>F45 <C-S-F9>
nmap <Leader>F46 <C-S-F10>
nmap <Leader>F47 <C-S-F11>
nmap <Leader>F48 <C-S-F12>
nmap <Leader>F49 <M-F1>
nmap <Leader>F50 <M-F2>
nmap <Leader>F51 <M-F3>
nmap <Leader>F52 <M-F5>
nmap <Leader>F53 <M-F5>
nmap <Leader>F54 <M-F6>
nmap <Leader>F55 <M-F7>
nmap <Leader>F56 <M-F8>
nmap <Leader>F57 <M-F9>
nmap <Leader>F58 <M-F10>
nmap <Leader>F59 <M-F11>
nmap <Leader>F60 <M-F12>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PuTTY for Windows {{{1

" NOTE: don't remap insert mode as they slow down the switch to Normal
" mode, which often interferes with my ability to then quickly hit `Cmd+s` in
" to save in vim GUIs.
" This isn't a problem withVisual mode because there's already a delay no
" matter what.
nmap <Esc>OA <Up>
nmap <Esc>OB <Down>
nmap <ESC>[Z <S-Tab>
vmap <Esc>OA <Up>
vmap <Esc>OB <Down>
vmap <ESC>[Z <S-Tab>
