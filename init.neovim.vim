""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" neovim

""" Language providers

if has("nvim") && has("mac")
    " On macOS, we can't use System perl:
    "   https://stackoverflow.com/questions/52682304/fatal-error-extern-h-file-not-found-while-installing-perl-modules/52997962#52997962
    let g:perl_host_prog = expand("$MYVIM/bin/nvim-perl")
endif

