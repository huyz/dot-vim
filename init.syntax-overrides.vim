""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Syntax highlighting overrides

function! HighlightStrangeWhitespace()
    " Highlight whitespace at end of line
    " (if there's more than one extra one or more than two extra ones in
    " the case of after a dot, so we don't get too much feedback as we type)
    " http://www.vim.org/tips/tip.php?tip_id=396
    " FIXME:
    "   - See improvements at http://vim.wikia.com/wiki/Highlighting_whitespaces_at_end_of_line
    "   - Doesn't work if TERM=xterm-256color
    " Test:
    highlight WhitespaceEOL term=reverse ctermfg=red ctermbg=NONE cterm=underline guifg=red guibg=NONE gui=underline
    " NOTE: lookbehind prevents matching on spaces at beginning of line
    match WhitespaceEOL /\([^.!? \t]\@<=\|[.!?]\s\)\s\s\+$/

    " Highlight Unicode whitespace characters
    " Test: [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ] [　] [ ] [ ]
    highlight UnicodeWhitespace term=reverse ctermfg=red ctermbg=NONE cterm=underline guifg=red guibg=NONE gui=reverse
    " The list is from https://stackoverflow.com/a/37903645 (with `\t`, `\n`, ` `, `\xa0` removed):
    call matchadd('UnicodeWhitespace', '[\x0b\x0c\r\x1c\x1d\x1e\x1f\x85\u1680\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u2028\u2029\u202f\u205f\u3000]')
endfunction

autocmd BufEnter,WinEnter * call HighlightStrangeWhitespace()

