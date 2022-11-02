""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Color schemes

function! SetBackgroundDark()
    execute 'colorscheme ' . g:colorscheme_dark
    set background=dark

    " Replace the default red color for the margin guides
    " NOTE: this needs to be after setting background
    highlight ColorColumn term=reverse ctermbg=darkgrey guibg=grey25

    if has('gui_macvim')
        " From https://github.com/macvim-dev/macvim/blob/master/runtime/colors/macvim.vim
        hi Normal       guifg=Grey50 guibg=Grey10
        hi Visual       guibg=MacSelectedTextBackgroundColor
        echo 'macvim'
    endif

    " 2021-07-02 On MacVim, can't see the cursor on top of yellow search results.  So tone down the yellow.
    " Don't really have time to make this cleaner
    if has('gui_running')
        highlight Search guifg=#282a2e guibg=#f0c674
    endif

    " Needed in GUI MacVim
    silent! exe 'AirlineRefresh'

    " Workaround for refreshing indent-guides' color detection
    silent! exe 'IndentGuidesToggle'
    silent! exe 'IndentGuidesToggle'
endfunction

function! SetBackgroundLight()
    execute 'colorscheme ' . g:colorscheme_light
    set background=light

    " Replace the default red color for the margin guides
    " NOTE: this needs to be after setting background
    highlight ColorColumn term=reverse ctermbg=lightgrey guibg=grey75

    if has('gui_macvim')
        " From https://github.com/macvim-dev/macvim/blob/master/runtime/colors/macvim.vim
        hi Normal       gui=NONE guifg=MacTextColor guibg=MacTextBackgroundColor
        hi Visual       guibg=MacSelectedTextBackgroundColor
        echo 'macvim'
    endif

    " Needed in GUI MacVim
    silent! exe 'AirlineRefresh'

    " Workaround for refreshing indent-guides' color detection
    silent! exe 'IndentGuidesToggle'
    silent! exe 'IndentGuidesToggle'
endfunction

function! ToggleBackground()
    if &background == "dark"
        call SetBackgroundLight()
    else
        call SetBackgroundDark()
    endif
endfunction

" Startup
let g:colorscheme_dark = "base16-tomorrow-night"
let g:colorscheme_light = "base16-tomorrow"
let g:airline_theme = 'base16_tomorrow'
if $TERM_PROGRAM =~ "iTerm" && !exists('$TMUX') && !exists('$STY')
    set termguicolors
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
