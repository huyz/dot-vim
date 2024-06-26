""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Color schemes

function! ToggleColorscheme()
    if g:colorscheme_light == 'default'
        let g:colorscheme_dark = "base16-tomorrow-night"
        let g:colorscheme_light = "base16-tomorrow"
    elseif has('gui_macvim') && g:colorscheme_light == 'base16-tomorrow'
        let g:colorscheme_dark = "macvim"
        let g:colorscheme_light = "macvim"
    else
        let g:colorscheme_dark = "default"
        let g:colorscheme_light = "default"
    endif
    call RefreshBackground()
endfunction

function! SetBackgroundDark()
    execute 'colorscheme ' . g:colorscheme_dark
    set background=dark

    if g:colorscheme_light == 'base16-tomorrow'
        silent! exec 'VMTheme sand'
    else
        silent! exec 'VMTheme'
    endif

    " Replace the default red color for the margin guides
    " NOTE: this needs to be after setting background
    highlight ColorColumn term=reverse ctermbg=252 guibg=Grey15

    if has('gui_macvim')
        " From https://github.com/macvim-dev/macvim/blob/master/runtime/colors/macvim.vim
        hi Normal       guifg=Grey50 guibg=Grey10
        hi Visual       guibg=MacSelectedTextBackgroundColor
    endif
    hi Cursor       guibg=LightGoldenrod guifg=bg
    hi CursorColumn guibg=Gray20                    ctermbg=253
    hi CursorIM     guibg=LightSlateGrey guifg=bg
    hi CursorLine   guibg=Gray20                    ctermbg=253
    hi lCursor      guibg=LightSlateGrey guifg=bg

    " For vim, i'm apparently supposed to do handle the linking myself
    " https://github.com/neoclide/coc.nvim/issues/4081
    if exists('g:vim')
        hi! link CocMenuSel PMenuSel
        hi! link CocSearch Identifier
    endif

    " 2021-07-02 On MacVim, can't see the cursor on top of yellow search results.  So tone down the yellow.
    " Don't really have time to make this cleaner
    if exists('g:gui_running')
        highlight Search guifg=#282a2e guibg=#f0c674
    endif

    " Needed in GUI MacVim
    silent! exe 'AirlineRefresh'

    " Workaround for refreshing indent-guides' color detection
    silent! exe 'IndentGuidesToggle'
    silent! exe 'IndentGuidesToggle'

    " GitHub copilot
    highlight CopilotSuggestion guifg=#4AA58A ctermfg=8
endfunction

function! SetBackgroundLight()
    execute 'colorscheme ' . g:colorscheme_light
    set background=light

    if g:colorscheme_light == 'base16-tomorrow'
        silent! exec 'VMTheme sand'
    else
        silent! exec 'VMTheme'
    endif

    " Replace the default red color for the margin guides
    " NOTE: this needs to be after setting background
    highlight ColorColumn term=reverse ctermbg=288 guibg=#F9F9F9

    if has('gui_macvim')
        " From https://github.com/macvim-dev/macvim/blob/master/runtime/colors/macvim.vim
        hi Normal       gui=NONE guifg=MacTextColor guibg=MacTextBackgroundColor
        hi Visual       guibg=MacSelectedTextBackgroundColor
    endif
    hi Cursor       guibg=fg guifg=bg
    hi CursorColumn guibg=#F1F1F1       ctermbg=6
    hi CursorIM     guibg=fg guifg=bg
    hi CursorLine   guibg=#F1F1F1       ctermbg=6
    hi lCursor      guibg=fg guifg=bg

    " For vim, i'm apparently supposed to do handle the linking myself
    " https://github.com/neoclide/coc.nvim/issues/4081
    if exists('g:vim')
        hi! link CocMenuSel PMenuSel
        hi! link CocSearch Identifier
    endif

    " Needed in GUI MacVim
    silent! exe 'AirlineRefresh'

    " Workaround for refreshing indent-guides' color detection
    silent! exe 'IndentGuidesToggle'
    silent! exe 'IndentGuidesToggle'

    " GitHub copilot
    highlight CopilotSuggestion guifg=#4AA58A ctermfg=8
endfunction

function! ToggleBackground()
    if &background == "dark"
        call SetBackgroundLight()
    else
        call SetBackgroundDark()
    endif
endfunction

function! RefreshBackground()
    if &background == "dark"
        call SetBackgroundDark()
    else
        call SetBackgroundLight()
    endif
endfunction

" Startup
"let g:colorscheme_dark = "default"
"let g:colorscheme_light = "default"
"let g:airline_theme = "simple"
let g:colorscheme_dark = "base16-tomorrow-night"
let g:colorscheme_light = "base16-tomorrow"
let g:airline_theme = "base16_tomorrow"
set termguicolors

call RefreshBackground()

if exists('g:nvim')
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

" if exists('g:nvim')
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
