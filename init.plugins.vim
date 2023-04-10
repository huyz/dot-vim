""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins options pre-loading {{{1

""" polyglot {{{2

" Sleuth requires that to avoid warning when invoked, but doesn't seem to make a
" difference
let g:polyglot_disabled = ["autoindent"]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins {{{1
" NOTE: this must run before `filetype plugin indent on` in order to pick
" up new file types in bundle, CoffeeScript

""" Init {{{2

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
call plug#begin('~/.vim/plugged')

" Conditional activation
" https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" WARNING: Make sure you use single quotes in the Plug lines below.
"   Even for the `exists('g:nvim')` pieces.  Weird, I know.

""" Built-in plugins {{{2

runtime macros/matchit.vim

""" Dependencies {{{2

" webapi-vim is required by gist-vim and optional for emmet-vim
Plug 'mattn/webapi-vim'

""" Plugins {{{2

" OS-specific directory for plugins
" This lets us share the ~/.vim directory using real-time syncing tools like syncthing or Resilio
let g:plug_os_dir = expand('~/.vim/plugged-' . g:uname)

" Files
Plug 'mhinz/vim-startify'
" plenary: dependency of telescope
Plug 'nvim-lua/plenary.nvim', Cond(exists('g:nvim'))
Plug 'nvim-telescope/telescope.nvim', Cond(exists('g:nvim'))
Plug 'nvim-telescope/telescope-fzf-native.nvim', Cond(exists('g:nvim'), { 'dir': g:plug_os_dir . '/telescope-fzf-native.nvim', 'do': 'make'})
Plug 'kien/ctrlp.vim'
" NOTE: we could re-use the fzf that's installed in Homebrew (which is used by zsh), but
" 1) it's more complicated to figure out where it's installed
" 2) linuxbrew isn't supported on ARM.
Plug 'junegunn/fzf', { 'dir': g:plug_os_dir . '/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" eunuch: some Unix file commands, e.g. Rename
Plug 'tpope/vim-eunuch'
Plug 'henrik/vim-reveal-in-finder'

" wilder
if exists('g:nvim')
    function! UpdateRemotePlugins(...)
        " Needed to refresh runtime files
        let &rtp=&rtp
        UpdateRemotePlugins
    endfunction

    Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
    Plug 'gelguy/wilder.nvim'
endif
" For wilder: To use Python remote plugin features in Vim, can be skipped
" 2022-10-25 Can't get python options to work in vim or neovim
" Plug 'roxma/nvim-yarp', Cond(!exists('g:nvim'))
" Plug 'roxma/vim-hug-neovim-rpc', Cond(!exists('g:nvim'))

" Colorscheme
" Plug 'f-person/auto-dark-mode.nvim', Cond(exists('g:nvim'))
Plug 'cormacrelf/dark-notify', Cond(exists('g:nvim'))
" auto-dark-mode: doesn't work in terminal
Plug 'L-TChen/auto-dark-mode.vim', Cond(exists('g:gui_vim') && exists('g:gui_running'))
Plug 'chriskempson/base16-vim'

" UI
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'kyazdani42/nvim-tree.lua', Cond(exists('g:nvim'))
Plug 'preservim/nerdtree', Cond(!exists('g:nvim'), { 'on': 'NERDTreeToggle' })
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'wesQ3/vim-windowswap'
Plug 'ryanoasis/vim-devicons', Cond(!exists('g:nvim'))
Plug 'kyazdani42/nvim-web-devicons', Cond(exists('g:nvim'))
Plug 'mbbill/undotree'
Plug 'brglng/vim-im-select'
" bbye: delete buffer preserving window layout
Plug 'moll/vim-bbye'
Plug 'ryvnf/readline.vim'

" Text
" you-keep-using-that-word: remap `cw`
Plug 'ap/vim-you-keep-using-that-word'
Plug 'tpope/vim-speeddating'
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-repeat'
Plug 'bronson/vim-visual-star-search'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'landock/vim-expand-region'
Plug 'matze/vim-move'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tommcdo/vim-exchange'
" Take fork for screaming case and to apply to kebab words
Plug 'nicwest/vim-camelsnek'
Plug 'christoomey/vim-titlecase'
" abolish: `:Subvert` is good for case-preserving substitute (but not for case conversions)
Plug 'tpope/vim-abolish'
" eregex: Support PCRE with `:S`
"Plug 'othree/eregex.vim'
" This fork implements incsearch
Plug 'https://github.com/ZSaberLv0/eregex.vim.git'

" Text objects
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'kana/vim-textobj-user'  " dependency of textobj-entire
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'PeterRincker/vim-argumentative'

" Markdown
Plug 'jkramer/vim-checkbox'
Plug 'dhruvasagar/vim-table-mode'
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'ellisonleao/glow.nvim', Cond(exists('g:nvim'))
" Plug 'RubenVerborgh/vim-markup-assistant'

" Dev
Plug 'airblade/vim-gitgutter'
" polyglot: collection of language packs
" TODO: how does this interact with coc/mason
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
" sleuth: automatic tab/space and indentation
Plug 'tpope/vim-sleuth'
Plug 'tomtom/tcomment_vim'
Plug 'Raimondi/delimitMate'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript', 'jsx', 'typescript', 'xml'] }
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescriptreact' }
Plug 'simrat39/symbols-outline.nvim', Cond(exists('g:nvim'))
" illuminate: highlight other usages
Plug 'RRethy/vim-illuminate'
" trouble: pretty diagnostics, references, telescope results, …
Plug 'folke/trouble.nvim', Cond(exists('g:nvim'))
let copilot_supported = exists('g:nvim') || v:version >= 801
Plug 'github/copilot.vim', Cond(copilot_supported)

Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
" vim gets syntastic
Plug 'scrooloose/syntastic', Cond(!exists('g:nvim'))
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
" treesitter: telescope apparently could use it
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" neovim gets coc or mason
let coc_supported = g:coc_or_mason == 'coc' && (exists('g:nvim') || v:version >= 801)
Plug 'neoclide/coc.nvim', Cond(coc_supported, {'branch': 'release'})
let mason_supported = g:coc_or_mason == 'mason' && exists('g:nvim')
Plug 'williamboman/mason.nvim', Cond(mason_supported)
Plug 'williamboman/mason-lspconfig.nvim', Cond(mason_supported)
Plug 'neovim/nvim-lspconfig', Cond(mason_supported)
Plug 'mfussenegger/nvim-dap', Cond(mason_supported)
" 2023-03-30 No condition needed anymore as we need null-ls for nvim-nu too
"Plug 'jose-elias-alvarez/null-ls.nvim', Cond(mason_supported)
Plug 'jose-elias-alvarez/null-ls.nvim'

" Git
Plug 'rhysd/git-messenger.vim'
Plug 'kdheepak/lazygit.nvim', Cond(exists('g:nvim'), {'branch': 'main'})
" Needed for automatic session naming function below for Startify
Plug 'itchyny/vim-gitbranch'
Plug 'Kachyz/vim-gitmoji'

" External Apps
Plug 'rizzatti/dash.vim', Cond(has('mac'))
Plug 'declancm/vim2vscode'
Plug 'voldikss/vim-browser-search'
Plug 'jamessan/vim-gnupg'
Plug 'lambdalisue/suda.vim', Cond(exists('g:nvim'))

" Misc
Plug 'dbeniamine/cheat.sh-vim'
Plug 'glacambre/firenvim', Cond(exists('g:nvim'), { 'do': { _ -> firenvim#install(0) } })


""" Initialize plugin system {{{2

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugin options {{{1

""" startify {{{2

let g:startify_session_dir = expand('$MYVIM/session-') . substitute(hostname(), '\..*', '', '')
if exists('g:nvim')
    let g:startify_session_before_save = [ 'silent! tabdo NvimTreeClose' ]
else
    let g:startify_session_before_save = [ 'silent! tabdo NERDTreeClose' ]
endif
let g:startify_session_persistence = 1
let g:startify_session_autoload = 1
let g:startify_session_sort = 1
let g:startify_session_number = 10
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1

" https://github.com/mhinz/vim-startify/wiki/Example-configurations#display-nerdtree-bookmarks-as-a-separate-list
" Read ~/.NERDTreeBookmarks file and takes its second column
function! s:nerdtreeBookmarks()
        let bookmarks = systemlist("cut -d' ' -f 2- ~/.NERDTreeBookmarks")
        let bookmarks = bookmarks[0:-2] " Slices an empty last line
        return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

" https://github.com/mhinz/vim-startify/wiki/Example-configurations#show-modified-and-untracked-git-files
" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
        let files = systemlist('git ls-files -m 2>/dev/null')
        return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
        let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
        return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
                \ { 'type': 'files',     'header': ['   MRU']            },
                \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
                \ { 'type': 'sessions',  'header': ['   Sessions']       },
                \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
                \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']},
                \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
                \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
                \ { 'type': 'commands',  'header': ['   Commands']       },
                \ ]

" https://github.com/mhinz/vim-startify/wiki/Example-configurations#auto-load-and-auto-save-a-session-named-from-git-branch
function! GetUniqueSessionName()
    let path = fnamemodify(getcwd(), ':~:t')
    let path = empty(path) ? 'no-project' : path
    let branch = gitbranch#name()
    let branch = empty(branch) ? '' : '-' . branch
    return substitute(path . branch, '/', '-', 'g')
endfunction
" XXX: This next line is giving me problems when I run :Startify
"autocmd User        StartifyReady silent execute 'SLoad '  . GetUniqueSessionName()
autocmd VimLeavePre *             silent execute 'SSave! ' . GetUniqueSessionName()

" Need to make sure the session directory exists, or SSave will prompt (and beacuse of the
" `silent`, you won't see a prompt to create a directory--just a pause
if !isdirectory(g:startify_session_dir)
    execute "!mkdir -p '" . g:startify_session_dir . "'"
endif

""" telescope {{{2

if exists('g:nvim')
    lua << EOF
    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require('telescope').load_extension('fzf')

    require('telescope').setup{
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            mappings = {
                i = {
                    ["<C-a>"] = { "<C-o>0", type = "command" },
                    ["<C-e>"] = { "<C-o>A", type = "command" },
                    ["<C-u>"] = { "<C-u>", type = "command" },

                    -- map actions.which_key to <C-h> (default: <C-/>)
                    -- actions.which_key shows the mappings for your picker,
                    -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                    -- ["<C-h>"] = "which_key",
                    ["<C-j>"] = {
                        require('telescope.actions').move_selection_next, type = "action",
                        opts = { nowait = true, silent = true }
                    },
                    ["<C-k>"] = {
                        require('telescope.actions').move_selection_previous, type = "action",
                        opts = { nowait = true, silent = true }
                    },
                    ["<C-n>"] = require('telescope.actions').cycle_history_next,
                    ["<C-p>"] = require('telescope.actions').cycle_history_prev,
                }
            }
        },
        pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
            find_files = {
                find_command = {'rg', '-L', '--hidden', '--glob', '!.git/', '--files'},
            },
            live_grep = {
                glob_pattern = '!.git/',
                additional_args = {
                    '-L',
                    '--hidden',
                    '--column',
                    '--line-number',
                    '--no-heading',
                    '--smart-case',
                },
            },
        },
        extensions = {
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure
        }
    }
EOF
endif

""" CtrlP {{{2

let g:ctrlp_cmd = 'CtrlPBuffer'

"set wildignore+=/tmp/,.so,.so p,*.zip
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|.venv|venv.*|node_modules)$',
    \ 'file': '\v\.(pyc|class|DS_Store)$',
    \ }

let g:ctrlp_max_files = 20000

""" fzf {{{2

" Focus buffer if it's already viewable
let g:fzf_buffers_jump = 1

" Tip: remember to keep these envvars in sync in your shell config files
let $FZF_DEFAULT_OPTS="--bind=ctrl-/:toggle-preview,ctrl-f:preview-page-down,ctrl-b:preview-page-up --preview '
    \ if [[ -d {} ]]; then ls -ACF --color=always {};
    \ elif [[ -f {} ]]; then [[ \$(file --mime \{\}) =~ binary ]] &&
    \ echo ''** binary file **'' ||
    \ (bat --plain --color=always {} || cat {}) 2> /dev/null | head -500; fi' "
let $FZF_DEFAULT_COMMAND="fd --follow --hidden --exclude .git"

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-r': 'vsplit' }
" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Default Rg command as of 2022-10-21:
"
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RG
    \ call fzf#vim#grep(
    \   'rg -L --hidden --glob "!.git/" --column --line-number --no-heading --color=always --smart-case -- '
    \   .shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

""" wilder {{{2
" 2022-10-25 Can't get python options to work in vim or neovim

call wilder#setup({
    \ 'modes': [':', '/', '?'],
    \ 'next_key': '<C-j>',
    \ 'previous_key': '<C-k>',
    \ 'accept_key': '<M-Enter>',
    \ 'reject_key': '<S-Esc>',
    \ })


call wilder#set_option('pipeline', [
    \   wilder#branch(
    \     wilder#cmdline_pipeline({
    \       'language': 'vim',
    \       'fuzzy': 1,
    \       'fuzzy_filter': wilder#vim_fuzzy_filter(),
    \     }),
    \   ),
    \ ])

call wilder#set_option('renderer', wilder#popupmenu_renderer())

""" nvim-tree {{{2

if exists('g:nvim')
    lua << EOF
    require("nvim-tree").setup()
EOF
endif

""" NERDtree {{{2

" Automatically close nvim if NERDTree is only thing left open
autocmd BufEnter * if (winnr("$") == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

""" bbye {{{2

call MapKey('<C-q><C-w>', '<Cmd>Bdelete<CR>')

""" indent-guides {{{2

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']

let g:indent_guides_color_change_percent = 3

""" easymotion {{{2

let g:EasyMotion_smartcase = 1

" n-character search
nmap - <Plug>(easymotion-sn)
" visual mode
xmap - <Plug>(easymotion-sn)
" operator-pending-mode, e.g. `d-ea`
" NOTE: `-tn` means the character before the match
omap - <Plug>(easymotion-tn)

" next match
map  _ <Plug>(easymotion-prev)
map  + <Plug>(easymotion-next)

""" CamelCaseMotion {{{2

let g:camelcasemotion_key = ','
omap <silent> i<leader>w <Plug>CamelCaseMotion_iw
xmap <silent> i<leader>w <Plug>CamelCaseMotion_iw
omap <silent> i<leader>b <Plug>CamelCaseMotion_ib
xmap <silent> i<leader>b <Plug>CamelCaseMotion_ib
omap <silent> i<leader>e <Plug>CamelCaseMotion_ie
xmap <silent> i<leader>e <Plug>CamelCaseMotion_ie
imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b
imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w

""" vim-move {{{2

" Disable the default mappings because they're bad on macOS
" https://github.com/matze/vim-move/issues/69#issuecomment-1199891566
let g:move_map_keys = 0

""" easy-align {{{2

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap gA <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap gA <Plug>(EasyAlign)

""" titlecase {{{2

let g:titlecase_map_keys = 0
let g:titlecase_excluded_words = ["và"]

""" ergex {{{2

" We want `:S` substitutions to be case-sensitive.
let g:eregex_force_case = 1

" Disable the default mappings because we have to do the mapping ourselves
let g:eregex_default_enable = 0
let g:eregex_forward_delim = '/'
let g:eregex_backward_delim = '?'

" Avoid total-file highlight because of the additional `\c`
let g:Fn_eregex_incsearch_filter = {x -> x == '\c'}

" Code from eregex.vim
let s:enable = 0
function! EregexToggle(...)
    let silent = 0
    if exists('a:1') && a:1
        let silent = 1
    endif
    if s:enable == 0
        " This is where I add the `\c` flag
        exec 'nnoremap <expr> '.g:eregex_forward_delim.' ":<C-U>".v:count1."M/\\c"'
        exec 'nnoremap <expr> '.g:eregex_backward_delim.' ":<C-U>".v:count1."M?\\c"'
        if silent != 1
            echo "eregex.vim key mapping enabled"
        endif
    else
        exec 'nunmap '.g:eregex_forward_delim
        exec 'nunmap '.g:eregex_backward_delim
        if silent != 1
            echo "eregex.vim key mapping disabled"
        endif
    endif
    let s:enable = 1 - s:enable
endfun

" Start out enabled
call EregexToggle(v:true)

""" checkbox {{{2

let g:checkbox_states = [' ', 'x', '\~']
let g:insert_checkbox_prefix = '- '

""" glow {{{2

" FIXME: dunno why I have to specify the style
if exists('g:nvim')
    lua << EOF
    require('glow').setup({
        style = "light",
    })
EOF
endif

""" tcomment {{{2

" Comment in first column
let g:tcomment#options = {
            \ 'col': 1,
            \ 'whitespace': 'no',
            \ 'strip_whitespace': '0'
            \ }
" Move the cursor to the next line.
let g:tcomment#mode_extra = '>|'

""" Hexokinase {{{2

if exists('g:nvim')
    let g:Hexokinase_highlighters = ['virtual']
else
    let g:Hexokinase_highlighters = ['backgroundfull']
endif
let g:Hexokinase_ftEnabled = ['vim', 'html', 'css', 'less', 'scss', 'stylus', 'javascript',
            \ 'markwhen']

""" nvim-nu {{{2

if exists('g:nvim')
    lua << EOF
    require("nu").setup()
EOF
endif


""" syntastic {{{2

set statusline+=%#warningmsg#
if exists('g:vim')
    set statusline+=%{SyntasticStatuslineFlag()}
endif
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_python_pylint_post_args  = "--max-line-length=100"

" on macOS 10.15.7: system "python" is still python2
let g:syntastic_python_checkers          = ['python3', 'pylint']

""" mason, lspconfig, null-ls {{{2

if exists('g:nvim') && g:coc_or_mason == 'mason'
    lua << EOF
    require("mason").setup({
        ui = {
            keymaps = {
            apply_language_filter = "<D-f>",
            }
        }
    })
    require("mason-lspconfig").setup()

    -- After setting up mason-lspconfig you may set up servers via lspconfig
    -- require("lspconfig").sumneko_lua.setup {}
    -- require("lspconfig").rust_analyzer.setup {}
    -- ...

    -- Or just setup all of the installed ones
    require('mason-lspconfig').setup_handlers({
        function(server)
            require('lspconfig')[server].setup({})
        end
    })
EOF
endif

""" messenger {{{2

let g:git_messenger_no_default_mappings = v:false
nmap <Leader>gb <Plug>(git-messenger)

""" gitmoji {{{2

set completefunc=emoji#complete
" Replace all :emoji_name: into Unicode emojis
nmap <Leader><C-U> <Cmd>%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>

""" cheat.sh {{{2

let g:CheatDoNotReplaceKeywordPrg = 1

""" gnupg {{{2

" NOTE: set in .vimrc.post
"let g:GPGDefaultRecipients = [ 'YOUR_GPG_EMAIL' ]

""" Firenvim {{{2

" Usage:
" - in browser, I have shift+alt+F set to trigger on
" - in nvim, hit Ctrl-C to save and exit (like ZZ)

" Commenting out to disable automatic execution
"                    \ '.*': { 'takeover': 'once', 'priority': 0 },
if exists('g:nvim')
    let g:firenvim_config = {
                \ 'localSettings': {
                    \ '.*': { 'takeover': 'never', 'priority': 0 },
                    \ 'https://([^/]+\.)?((excalidraw|kodezi|slack|writesonic)\.com|open\.ai)/':
                    \    { 'takeover': 'never', 'priority': 1 },
                    \ 'https://translate\.google\.com/':
                    \    { 'takeover': 'never', 'priority': 1 },
                    \ 'https://dev\.to/onboarding':
                    \    { 'takeover': 'never', 'priority': 1 },
                    \ 'https://github.com/.*/(edit|new)/':
                    \    { 'takeover': 'never', 'priority': 1 },
                \ }
    \ }

    function! FirenvimMappings()
        " Get Copy and Paste working inside the browser
        vnoremap <D-x> "+d
        vnoremap <D-c> "+y
        vnoremap <D-v> "+gP
        nnoremap <D-v> "+gP
        cnoremap <D-v> <C-R>+
        inoremap <D-v> <C-R><C-O>+

        " Easy exit
        nnoremap <C-c> ZZ
        vnoremap <C-c> ZZ
        inoremap <C-c> <C-O>ZZ
    endfunction

    function! OnUIEnter(event) abort
        if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
            call FirenvimMappings()
            set laststatus=0 shortmess+=F
            set signcolumn=no
            set nolist nonumber norelativenumber nocursorline showbreak=  nocursorcolumn
        endif
    endfunction
    autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
endif

" vim:foldmethod=marker:
