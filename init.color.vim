""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Color schemes

function! SetBackgroundDark()
    execute 'colorscheme ' . g:colorscheme_dark
    set background=dark

    " NOTE: this needs to be after setting background
    highlight ColorColumn term=reverse ctermbg=darkgrey guibg=grey25
    " For reference: Auto colors by g:indent_guides_auto_colors=1
    "highlight IndentGuidesOdd ctermfg=242 ctermbg=0 guifg=grey15 guibg=grey30
    "highlight IndentGuidesEven ctermfg=0 ctermbg=242 guifg=grey30 guibg=grey15
    " FIXME: can't get guibg to take effect on startup
    highlight IndentGuidesEven guibg=grey23

    " 2021-07-02 On MacVim, can't see the cursor on top of yellow search results.  So tone down the yellow.
    " Don't really have time to make this cleaner
    if has("gui_running")
        highlight Search guifg=#282a2e guibg=#f0c674
    endif
endfunction

function! SetBackgroundLight()
    execute 'colorscheme ' . g:colorscheme_light
    set background=light

    " NOTE: this needs to be after setting background
    highlight ColorColumn term=reverse ctermbg=lightgrey guibg=grey75
    " For reference: Auto colors by g:indent_guides_auto_colors=1
    " Auto colors by g:indent_guides_auto_colors=1
    "highlight IndentGuidesOdd ctermfg=7 ctermbg=15 guifg=grey70 guibg=grey85
    "highlight IndentGuidesEven ctermfg=15 ctermbg=7 guifg=grey85 guibg=grey70
endfunction

function! ToggleBackground()
    if &background == "dark"
        call SetBackgroundLight()
    else
        call SetBackgroundDark()
    endif
endfunction

" Startup
if $TERM_PROGRAM =~ "iTerm" && !exists('$TMUX') && !exists('$STY')
    let g:airline_theme = 'base16_tomorrow'
    set termguicolors
    let g:colorscheme_dark = "base16-tomorrow-night"
    let g:colorscheme_light = "base16-tomorrow"
else
    let g:airline_theme = 'base16_colors'
    " if has("gui_vimr") || exists("g:neovide")
    "     " VimR can't seem to understand what `default` combined with `bg=light` should end up with
    "     let g:colorscheme_dark = "base16-tomorrow-night"
    "     let g:colorscheme_light = "base16-tomorrow"
    " else
        let g:colorscheme_dark = "default"
        let g:colorscheme_light = "default"
    " endif
endif

if &background == 'dark'
    call SetBackgroundDark()
else
    call SetBackgroundLight()
endif

if has("nvim")
    :lua <<EOF
    require('dark_notify').run({
        onchange = function(mode)
            -- optional, you can configure your own things to react to changes.
            -- this is called at startup and every time dark mode is switched,
            -- either via the OS, or because you manually set/toggled the mode.
            -- mode is either "light" or "dark"
            if (mode == "dark")
            then
                vim.api.nvim_call_function("SetBackgroundDark", {})
            else
                vim.api.nvim_call_function("SetBackgroundLight", {})
            end
        end,
    })
EOF
endif

" if has("nvim")
"     lua << EOF
"     local auto_dark_mode = require('auto-dark-mode')

"     auto_dark_mode.setup({
"         update_interval = 1000,
"         set_dark_mode = function()
"             vim.api.nvim_set_option('background', 'dark')
"             vim.cmd('colorscheme gruvbox')
"         end,
"         set_light_mode = function()
"             vim.api.nvim_set_option('background', 'light')
"             vim.cmd('colorscheme gruvbox')
"         end,
"     })
"     auto_dark_mode.init()
" EOF
" endif
