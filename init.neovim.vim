if exists('g:nvim')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" neovim

""" Language providers

if filereadable(expand("$MYVIM/bin/nvim-perl"))
    " On macOS, we can't use System perl:
    "   https://stackoverflow.com/questions/52682304/fatal-error-extern-h-file-not-found-while-installing-perl-modules/52997962#52997962
    let g:perl_host_prog = expand("$MYVIM/bin/nvim-perl")
elseif filereadable("/opt/homebrew/bin/perl")
    let g:perl_host_prog = "/opt/homebrew/bin/perl"
elseif filereadable("/usr/local/bin/perl")
    let g:perl_host_prog = "/usr/local/bin/perl"
elseif filereadable("/home/linuxbrew/.linuxbrew/bin/perl")
    let g:perl_host_prog = "/home/linuxbrew/.linuxbrew/bin/perl"
else
    let g:perl_host_prog = "/usr/bin/perl"
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
endif " exists('g:nvim')
