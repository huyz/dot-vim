" after/ftplugin Vim script for mail
" huyz

" Disable autoindent
setlocal noai

" 2011-05-28 Leave hard autowrap at default 72
"setlocal tw=0
" Break lines at word boundaries
setlocal linebreak

set keywordprg=dict

" Allow dictionary completion on aliases first
" mutt aliases
if filereadable(expand("~/.muttrc.aliases"))
  set dictionary^=~/.muttrc.aliases
endif
" MH aliases
if filereadable(expand("~/Mail/aliases"))
  set dictionary^=~/Mail/aliases
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For me only
if $USER == $ME

" Turn on spellcheck
" After brief attempt, can't get the dictionaries to download automatically
"setlocal spell spelllang=en_us,fr_fr,es_es,pt_br

" If there's a signature, let's remap G so that we can still use it
if filereadable(expand("~/.signature"))
  nmap G /<C-U>^---* *$/<CR>k
endif

" 2007-10-05 Disabled because we need ^X^K
" 2004-09-13 Bind ^X to save and exit
" imap <C-X> <Esc>ZZ
" nmap <C-X> ZZ

" 2003-11-24 Disabled
" Turn on vimspell automatically
"  nunmap \ss
"  runtime macros/vimspell.vim

endif
