""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim-specific

if has("gui_macvim")
  set guifont=Monaco:h12

  " Overwrite functions of https://github.com/L-TChen/auto-dark-mode.vim/blob/master/plugin/autoDark.vim
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

" vim:set ai et sts=2 sw=2 tw=0:
