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
" - Avoid using standard Vim directory names like 'plugin'
" - Normallly, for Neovim it would be: ~/.local/share/nvim/plugged
call plug#begin('~/.vim/plugged')

" Conditional activation
" https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" WARNING: Make sure you use single quotes in the Plug lines below.
"   Even for the `has("nvim")` pieces.  Weird, I know.

""" Built-in plugins {{{2

runtime macros/matchit.vim

""" Dependencies {{{2

" webapi-vim is required by gist-vim and optional for emmet-vim
Plug 'mattn/webapi-vim'

""" Plugins {{{2
Plug 'tpope/vim-eunuch'

" Files
Plug 'mhinz/vim-startify'
Plug 'kien/ctrlp.vim'
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'

" wilder
if has('nvim')
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
" Plug 'roxma/nvim-yarp', Cond(!has('nvim'))
" Plug 'roxma/vim-hug-neovim-rpc', Cond(!has('nvim'))

" Colorscheme
" Plug 'f-person/auto-dark-mode.nvim', Cond(has('nvim'))
Plug 'cormacrelf/dark-notify', Cond(has('nvim'))
Plug 'L-TChen/auto-dark-mode.vim', Cond(!has('nvim') && has('gui_running'))
Plug 'chriskempson/base16-vim'

" UI
Plug 'kyazdani42/nvim-tree.lua', Cond(has('nvim'))
Plug 'preservim/nerdtree', Cond(!has('nvim'))
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'wesQ3/vim-windowswap'
Plug 'ryanoasis/vim-devicons'
Plug 'sjl/gundo.vim'
Plug 'brglng/vim-im-select'
" bbye: delete buffer preserving window layout
Plug 'moll/vim-bbye'
Plug 'ryvnf/readline.vim'

" Text
" you-keep-using-that-word: remap `cw`
Plug 'ap/vim-you-keep-using-that-word'
Plug 'tpope/vim-repeat'
Plug 'bronson/vim-visual-star-search'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'landock/vim-expand-region'
Plug 'matze/vim-move'
Plug 'junegunn/vim-easy-align'
Plug 'dhruvasagar/vim-table-mode'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tommcdo/vim-exchange'
Plug 'nicwest/vim-camelsnek'
Plug 'christoomey/vim-titlecase'
" abolish is good for :S case-preserving substitute but not for case conversions
Plug 'tpope/vim-abolish'

" Text objects
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'kana/vim-textobj-user'  " dependency of textobj-entire
Plug 'kana/vim-textobj-entire'
Plug 'PeterRincker/vim-argumentative'

" Markdown
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }


" Dev
" polyglot: collection of language packs
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript', 'jsx', 'typescript', 'xml'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'jsx', 'typescript'] }
let coc_supported = has('nvim') || v:version >= 801
Plug 'neoclide/coc.nvim', Cond(coc_supported, {'branch': 'release'})
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescriptreact' }
Plug 'simrat39/symbols-outline.nvim', Cond(has('nvim'))

" Git
Plug 'rhysd/git-messenger.vim'
Plug 'kdheepak/lazygit.nvim', Cond(has('nvim'), {'branch': 'main'})
" Needed for automatic session naming function below for Startify
Plug 'itchyny/vim-gitbranch'
Plug 'Kachyz/vim-gitmoji'
Plug 'mattn/gist-vim'

" Misc
Plug 'dbeniamine/cheat.sh-vim'
Plug 'jamessan/vim-gnupg'
Plug 'glacambre/firenvim', Cond(has('nvim'), { 'do': { _ -> firenvim#install(0) } })


""" Initialize plugin system {{{2

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugin options {{{1

""" startify {{{2

let g:startify_session_dir = '~/.vim/session'
if has("nvim")
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

""" CtrlP {{{2

let g:ctrlp_cmd = 'CtrlPBuffer'

"set wildignore+=/tmp/,.so,.so p,*.zip
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|.venv|venv.*|node_modules)$',
    \ 'file': '\v\.(pyc|class|DS_Store)$',
    \ }

let g:ctrlp_max_files = 20000

""" fzf {{{2

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
    \ 'next_key': '<C-n>',
    \ 'previous_key': '<C-p>',
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

if has("nvim")
    lua << EOF
require("nvim-tree").setup()
EOF
endif

""" NERDtree {{{2

" Automatically close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""" bbye {{{2

noremap <C-w><C-q> <Cmd>Bdelete<CR>

""" indent-guides {{{2

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']


""" visual-multi {{{2

let g:VM_mouse_mappings = 1

let g:VM_maps = {}
" Enable undo in order to restore regions
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'

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

""" expand-region {{{2

map <C-S-Right> <Plug>(expand_region_expand)
map <C-S-Left> <Plug>(expand_region_shrink)

""" vim-move {{{2

" Disable the default mappings because they're bad on macOS
" https://github.com/matze/vim-move/issues/69#issuecomment-1199891566
let g:move_map_keys = 0

if has("gui_running")
    nmap <M-Down> <Plug>MoveLineDown
    nmap <M-Up> <Plug>MoveLineUp
    nmap <M-Left> <Plug>MoveCharLeft
    nmap <M-Right> <Plug>MoveCharRight
    vmap <M-Down> <Plug>MoveBlockDown
    vmap <M-Up> <Plug>MoveBlockUp
    vmap <M-Left> <Plug>MoveBlockLeft
    vmap <M-Right> <Plug>MoveBlockRight
else
    nmap <Esc><Down> <Plug>MoveLineDown
    nmap <Esc><Up> <Plug>MoveLineUp
    nmap <Esc><Left> <Plug>MoveCharLeft
    nmap <Esc><Right> <Plug>MoveCharRight

    " WARNING: if instead of using h,j,k,l, you tend to use arrow keys for motion
    " in Normal mode, then the mappings below may interfere when you try to exit
    " out of Visual mode with <Esc> and immediately hit an arrow key. In that
    " case, you might want to use the `C` modifier instead as here:
    "vmap <C-Down> <Plug>MoveBlockDown
    "vmap <C-Up> <Plug>MoveBlockUp
    "vmap <C-Left> <Plug>MoveBlockLeft
    "vmap <C-Right> <Plug>MoveBlockRight
    vmap <Esc><Down> <Plug>MoveBlockDown
    vmap <Esc><Up> <Plug>MoveBlockUp
    vmap <Esc><Left> <Plug>MoveBlockLeft
    vmap <Esc><Right> <Plug>MoveBlockRight
endif

""" easy-align {{{2

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap gA <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap gA <Plug>(EasyAlign)

""" titlecase {{{2

let g:titlecase_excluded_words = ["và"]

""" markdown-preview {{{2

nmap µµ <Cmd>MarkdownPreview<CR>
" FIXME: doesn't work
"call MapKey('<M-m><M-m>', '<Cmd>MarkdownPreview<CR>')

""" NERDcommenter options {{{2

map <Leader>c/ <plug>NERDCommenterAlignBoth
"map <Leader>bj <plug>NERDCommenterAlignBoth

""" syntastic {{{2

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_python_pylint_post_args  = "--max-line-length=100"

" on macOS 10.15.7: system "python" is still python2
let g:syntastic_python_checkers          = ['python3', 'pylint']

""" coc {{{2

let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier',
            \ 'coc-tsserver', 'coc-pyright', 'coc-git']
let g:python3_host_prog = expand("~/.pyenv/versions/py3nvim/bin/python")

" Usage: type `:Prettier` to format whole document
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Usage: select range and invoke `\f`
nnoremap <space>f <Plug>(coc-format-selected)
vnoremap <space>f <Plug>(coc-format-selected)

""" git-messenger

let g:git_messenger_no_default_mappings = v:false
nmap <Leader>gb <Plug>(git-messenger)

""" gitmoji {{{2

set completefunc=emoji#complete
" Replace all :emoji_name: into Unicode emojis
nmap <Leader><C-U> <Cmd>%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>

""" gist {{{2

" NOTE: set in .vimrc.post
"let g:github_user  = "YOUR_GITHUB_USERNAME"
"let g:github_token = "YOUR_GITHUB_API_TOKEN"

""" gnupg {{{2

" NOTE: set in .vimrc.post
"let g:GPGDefaultRecipients = [ 'YOUR_GPG_EMAIL' ]

""" Firenvim {{{2

if has("nvim")
    let g:firenvim_config = {
                \ 'localSettings': {
                    \ '.*': { 'takeover': 'once', 'priority': 0 },
                    \ 'https?://(?:[^/]+\.)excalidraw\.com/': { 'takeover': 'never', 'priority': 1 },
                    \ 'https?://[^/]+\.slack\.com/': { 'takeover': 'never', 'priority': 1 }
                \ }
    \ }

    function! RemapCopyAndPaste()
        " Get Copy and Paste working inside the browser
        vnoremap <D-x> "+d
        vnoremap <D-c> "+y
        vnoremap <D-v> "+gP
        nnoremap <D-v> "+gP
        cnoremap <D-v> <C-R>+
        inoremap <D-v> <C-R><C-O>+
    endfunction

    if exists('g:started_by_firenvim')
        set laststatus=0
        call RemapCopyAndPaste()
    endif
    function! OnUIEnter(event) abort
        if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
            set laststatus=0
            call RemapCopyAndPaste()
        endif
    endfunction
    autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
endif

" vim:foldmethod=marker:
