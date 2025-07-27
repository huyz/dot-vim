""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim-specific

if exists('g:gui_running')
  if exists('g:neovide')
    " Default neovide font:
    "set guifont=Fira\ Mono\ for\ Powerline:h12
    set guifont=MesloLGM\ Nerd\ Font\ Mono:h12
  else
    " To display devicons
    set guifont=MesloLGMNFM-Regular:h12
    " To make it spaced like in iTerm
    set linespace=1
  endif

  "set background=dark
  " This is to counteract the 'colorscheme default' in .vimrc
  "colorscheme macvim
  " XXX dunno why I have to reset highlight after setting background to dark
  "highlight ColorColumn term=reverse ctermbg=darkgrey guibg=black

  " Overwrite functions of https://github.com/L-TChen/auto-dark-mode.vim/blob/master/plugin/autoDark.vim
  if exists('g:vim')
    func! s:ChangeBackground()
      if (v:os_appearance)
        call SetBackgroundDark()
      else
        call SetBackgroundLight()
      endif
      redraw!
    endfunc

    augroup AutoDark
    autocmd OSAppearanceChanged * call s:ChangeBackground()
    augroup END
  endif
endif

" vim:set ai et sts=2 sw=2 tw=0:
