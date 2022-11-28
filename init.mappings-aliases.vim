""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" macOS: make composed keys act like Meta {{{1

" TODO: test macmeta. I don't really want to use macmeta because I want to retain some of the
"   Mac's composed characters, especially the digraphs.

" If in neovim GUI, or in vim GUI in non-macmeta mode
if has('mac') && (exists('g:gui_nvim') || (exists('g:gui_macvim') && !has('macmeta')))
    " Exceptions for insert mode:
    " - Can't remap `, e, u, i, n as these are used to compose digraph prefixes
    " - Won't remap ∞, ·, –, —, ≈, ≠, ±, ≤, ≥, …  as these are useful special characters even to
    "   Americans
    " - Won't remap ¡, ¿, ç, €, «, » for European text
    call MapAlias('å', '<M-a>')
    call MapAlias('Å', '<M-A>')
    call MapAlias('∫', '<M-b>')
    call MapAlias('ı', '<M-B>')
    call MapAlias('ç', '<M-c>')
    call MapAlias('Ç', '<M-C>')
    call MapAlias('∂', '<M-d>')
    call MapAlias('Î', '<M-D>')
    call MapAlias('´', '<M-E>')
    call MapAlias('ƒ', '<M-f>')
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
    call MapAlias('¡', '<M-1>', 'all', v:true)
    call MapAlias('⁄', '<M-!>')
    call MapAlias('™', '<M-2>')
    call MapAlias('€', '<M-@>', 'all', v:true)
    call MapAlias('£', '<M-3>')
    call MapAlias('‹', '<M-#>')
    call MapAlias('¢', '<M-4>')
    call MapAlias('›', '<M-$>')
    call MapAlias('∞', '<M-5>', 'all', v:true)
    call MapAlias('ﬁ', '<M-%>')
    call MapAlias('§', '<M-6>')
    call MapAlias('ﬂ', '<M-^>')
    call MapAlias('¶', '<M-7>')
    call MapAlias('‡', '<M-&>')
    call MapAlias('•', '<M-8>')
    call MapAlias('°', '<M-*>')
    call MapAlias('ª', '<M-9>')
    call MapAlias('·', '<M-(>', 'all', v:true)
    call MapAlias('º', '<M-0>')
    call MapAlias('‚', '<M-)>')
    call MapAlias('–', '<M-->', 'all', v:true)
    call MapAlias('—', '<M-_>', 'all', v:true)
    call MapAlias('≠', '<M-=>', 'all', v:true)
    call MapAlias('±', '<M-+>', 'all', v:true)
    call MapAlias('“', '<M-[>')
    call MapAlias('”', '<M-{>')
    call MapAlias('‘', '<M-]>')
    call MapAlias('’', '<M-}>')
    call MapAlias('«', '<M-Bslash>', 'all', v:true)
    call MapAlias('»', '<M-Bar>', 'all', v:true)
    call MapAlias('…', '<M-;>')
    call MapAlias('Ú', '<M-:>')
    call MapAlias('æ', "<M-'>")
    call MapAlias('Æ', '<M-">')
    call MapAlias('≤', '<M-,>', 'all', v:true)
    call MapAlias('¯', '<M-lt>')
    call MapAlias('≥', '<M-.>', 'all', v:true)
    call MapAlias('˘', '<M->>')
    call MapAlias('¿', '<M-?>')
    call MapAlias('÷', '<M-/>')

    if exists('g:gui_macvim')
        " TODO: automate these MapAlias whenever they're used
        "   instead of mapping them ahead of time.
        " BrowserSearch
        call MapAlias('ßß', '<M-s><M-s>')
        " MarkdownPreview
        call MapAlias('µµ', '<M-m><M-m>')
        " Glow
        call MapAlias('µπ', '<M-m><M-p>')
        "call MapAlias('µ¬', '<M-m><M-l>')

        " Move tab first or last
        call MapAlias('<D-”>', '<M-S-D-{>')
        call MapAlias('<D-’>', '<M-S-D-}>')
        " Close tab
        call MapAlias('<D-„>', '<M-S-D-w>')
        " Equalize splits
        call MapAlias('<D-‚>', '<M-S-D-)>')
        " Maximize splits
        call MapAlias('<D-»>', '<M-S-D-Bar>')
        " Increment/decrement
        call MapAlias('<D-—>', '<M-S-D-_>')
        call MapAlias('<D-±>', '<M-S-D-+>')
        " Code navigation
        call MapAlias('<D-∫>', '<M-D-b>')
        " TCommentInline
        call MapAlias('<D-÷>', '<M-D-/>')
        " Markdown code block
        call MapAlias('<D-Ç>', '<M-S-D-c>')
    endif


elseif exists('g:tui_vim') && exists('g:use_extended_keys_in_terminal') && g:use_extended_keys_in_terminal

    " NOTE: Most of these aliases are actually no longer necessary if the commands in init.options.vim
    " were successful (and makes vim act like neovim):
    "   " Enable CSI-u mode
    "   let &t_TI = "\<Esc>[>4;2m"
    "   let &t_TE = "\<Esc>[>4;m"
    if v:false
        call MapAlias('á', '<M-a>')
        call MapAlias('Á', '<M-A>')
        call MapAlias('â', '<M-b>')
        call MapAlias('Â', '<M-B>')
        call MapAlias('ã', '<M-c>')
        call MapAlias('Ã', '<M-C>')
        call MapAlias('ä', '<M-d>')
        call MapAlias('Ä', '<M-D>')
        call MapAlias('å', '<M-e>')
        call MapAlias('å', '<M-E>')
        call MapAlias('æ', '<M-f>')
        call MapAlias('Æ', '<M-F>')
        call MapAlias('ç', '<M-g>')
        call MapAlias('Ç', '<M-G>')
        call MapAlias('è', '<M-h>')
        call MapAlias('È', '<M-H>')
        call MapAlias('é', '<M-i>')
        call MapAlias('É', '<M-I>')
        call MapAlias('ê', '<M-j>')
        call MapAlias('Ê', '<M-J>')
        call MapAlias('ë', '<M-k>')
        call MapAlias('Ë', '<M-K>')
        call MapAlias('ì', '<M-l>')
        call MapAlias('Ì', '<M-L>')
        call MapAlias('í', '<M-m>')
        call MapAlias('Í', '<M-M>')
        call MapAlias('î', '<M-n>')
        call MapAlias('Î', '<M-N>')
        call MapAlias('ï', '<M-o>')
        call MapAlias('Ï', '<M-O>')
        call MapAlias('ð', '<M-p>')
        call MapAlias('Ð', '<M-P>')
        call MapAlias('ñ', '<M-q>')
        call MapAlias('Ñ', '<M-Q>')
        call MapAlias('ò', '<M-r>')
        call MapAlias('Ò', '<M-R>')
        call MapAlias('ó', '<M-s>')
        call MapAlias('Ó', '<M-S>')
        call MapAlias('ô', '<M-t>')
        call MapAlias('Ô', '<M-T>')
        call MapAlias('õ', '<M-u>')
        call MapAlias('Õ', '<M-U>')
        call MapAlias('ö', '<M-v>')
        call MapAlias('Ö', '<M-V>')
        call MapAlias('÷', '<M-w>')
        call MapAlias('×', '<M-W>')
        call MapAlias('ø', '<M-x>')
        call MapAlias('Ø', '<M-X>')
        call MapAlias('ù', '<M-y>')
        call MapAlias('Ù', '<M-Y>')
        call MapAlias('ú', '<M-z>')
        call MapAlias('Ú', '<M-Z>')
        call MapAlias('±', '<M-1>')
        call MapAlias('¡', '<M-!>')
        call MapAlias('²', '<M-2>')
        call MapAlias('À', '<M-@>')
        call MapAlias('³', '<M-3>')
        call MapAlias('£', '<M-#>')
        call MapAlias('´', '<M-4>')
        call MapAlias('¤', '<M-$>')
        call MapAlias('µ', '<M-5>')
        call MapAlias('¥', '<M-%>')
        call MapAlias('¶', '<M-6>')
        call MapAlias('Þ', '<M-^>')
        call MapAlias('·', '<M-7>')
        call MapAlias('¦', '<M-&>')
        call MapAlias('¸', '<M-8>')
        call MapAlias('ª', '<M-*>')
        call MapAlias('¹', '<M-9>')
        call MapAlias('¨', '<M-(>')
        call MapAlias('°', '<M-0>')
        call MapAlias('©', '<M-)>')
        call MapAlias('­', '<M-->')
        call MapAlias('ß', '<M-_>')
        call MapAlias('½', '<M-=>')
        call MapAlias('«', '<M-+>')
        call MapAlias('ÿ', '<M-BS>')
        call MapAlias('Û', '<M-[>')
        call MapAlias('û', '<M-{>')
        call MapAlias('Ý', '<M-]>')
        call MapAlias('ý', '<M-}>')
        call MapAlias('Ü', '<M-Bslash>')
        call MapAlias('ü', '<M-Bar>')
        call MapAlias('»', '<M-;>')
        call MapAlias('º', '<M-:>')
        call MapAlias('§', "<M-'>")
        call MapAlias('¢', '<M-">')
        call MapAlias('¬', '<M-,>')
        call MapAlias('¼', '<M-lt>')
        call MapAlias('®', '<M-.>')
        call MapAlias('¾', '<M->>')
        call MapAlias('¯', '<M-/>')
        call MapAlias('¿', '<M-?>')

        " Go back/forward and/or CamelCaseMotion
        " NOTE: that should actually be `;10` but iTerm seems to ignore ⌘
        "   (which is ok because iTerm grabs ⌘← anyway)
        " XXX iTerm inconsistent, as ⌥ is Meta here, but Alt elsewhere
        call MapAlias('[1;9D', '<M-D-Left>')
        call MapAlias('[1;9C', '<M-D-Right>')
        call MapAlias('[1;13D', '<M-C-Left>')
        call MapAlias('[1;13C', '<M-C-Right>')

        " Previous edit location
        " XXX iTerm inconsistent, as ⌥ is Alt here, but Meta elsewhere
        call MapAlias('[27;4;127~', '<M-S-BS>')
        " Delete parts of line
        call MapAlias('[3;3~', '<M-Del>')
        call MapAlias('[27;3;127~', '<M-BS>')

        " Go to previous/next method
        " XXX iTerm inconsistent, as ⌥ is Meta here, but Alt elsewhere
        "call MapAlias('[1;14A', '<C-S-M-Up>')
        "call MapAlias('[1;14B', '<C-S-M-Down>')

        call MapAlias('[1;14D', '<C-S-M-Left>')
        call MapAlias('[1;14C', '<C-S-M-Right>')
        " Close tab
        call MapAlias('[27;5;87~', '<M-C-w>')
        " Equalize splits
        " XXX iTerm inconsistent, as ⌥ is Alt here, but Meta elsewhere
        call MapAlias('[27;8;43~', '<M-C-+>')
        " Maximize split. FIXME: can't get vim in terminal to work
        " XXX iTerm inconsistent, as ⌥ is Alt here, but Meta elsewhere
        call MapAlias('[27;8;124~', '<M-C-Bar>')
        " Move tabs
        call MapAlias('[27;6;123~', '<C-S-{>')
        call MapAlias('[27;6;125~', '<C-S-}>')
        " Code navigation.
        call MapAlias('[27;5;66~', '<M-C-b>')
        " Commenting
        call MapAlias('[27;7;47~', '<C-M-/>')
        " Markdown codeblock
        " Because neovim in terminal can't seem to emit a key that I program into iTerm
        "   (as I tried below; probably because of "CSi u Mode"), we have to rely on BetterTouchTool
        "   to map <M-S-D-c> to <M-C-S-C>.
        " NOTE: manually added that made-up code (added +8 to `<M-S-c>`) in iTerm
        "call MapAlias('[27;12;67~', '<M-S-D-c>')
        call MapAlias('[27;8;67~', '<M-C-S-c>')

        " Invoke Startify
        " TODO: not tested
        "call MapAlias('[27;4;34~', '<D-S-">')
    endif

    " Equalize splits
    call MapAlias('[27;8;41~', '<M-C-)>')
    " Maximize splits
    call MapAlias('[27;8;124~', '<M-C-Bar>')
    call MapAlias('[1;14A', '<M-C-S-Up>')
    call MapAlias('[1;14B', '<M-C-S-Down>')
    call MapAlias('[1;14D', '<M-C-S-Left>')
    call MapAlias('[1;14C', '<M-C-S-Right>')

    " visual-multi
    call MapAlias('[1;9A', '<M-Up>')
    call MapAlias('[1;9B', '<M-Down>')
    call MapAlias('[1;9D', '<M-Left>')
    call MapAlias('[1;9C', '<M-Right>')

    " vim-move
    call MapAlias('[1;13A', '<M-C-Up>')
    call MapAlias('[1;13B', '<M-C-Down>')
    call MapAlias('[1;13D', '<M-C-Left>')
    call MapAlias('[1;13C', '<M-C-Right>')

    " increment/decrement
    call MapAlias('[28;8;95~', '<M-C-_>')
    call MapAlias('[27;8;43~', '<M-C-+>')
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Function key aliases
" neovim reads terminfo to decide what function key to assign:
"   https://github.com/neovim/neovim/issues/8317#issuecomment-384577645
" So we have to duplicate the work we've done in .exrc
if exists('g:tui_nvim')
    call MapAlias('<F13>', '<S-F1>')
    call MapAlias('<F14>', '<S-F2>')
    call MapAlias('<F15>', '<S-F3>')
    call MapAlias('<F16>', '<S-F4>')
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
    call MapAlias('<F28>', '<C-F4>')
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
    call MapAlias('<F40>', '<C-S-F4>')
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
    call MapAlias('<F52>', '<M-F4>')
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
nmap <Leader>F16 <S-F4>
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
nmap <Leader>F28 <C-F4>
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
nmap <Leader>F40 <C-S-F4>
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
nmap <Leader>F52 <M-F4>
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
