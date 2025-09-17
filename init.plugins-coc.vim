""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Recommended configuration {{{2
" Source: https://github.com/neoclide/coc.nvim#example-vim-configuration

" May need for vim (not neovim) since coc.nvim calculate byte offset by count
" utf-8 byte sequence.
"set encoding=utf-8
" Some servers have issues with backup files, see #649.
"set nobackup
" huy 2022-10-25: we'll uncomment that when it becomes a problem.
"set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if exists('g:nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
call MapKey('<S-F8>', '<Plug>(coc-diagnostic-prev)')
call MapKey('<F8>', '<Plug>(coc-diagnostic-next)')

" Try coc definition, otherwise search tags, otherwise fall back to `gd`
" https://github.com/neoclide/coc.nvim/issues/1445#issuecomment-570856671
function! s:GoToDefinition()
    if CocAction('jumpDefinition')
        return v:true
    endif

    let ret = execute("silent! normal \<C-]>")
    if ret =~ "Error" || ret =~ "错误"
        call searchdecl(expand('<cword>'))
    endif
endfunction

" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd <Cmd>call <SID>GoToDefinition()<CR>
nmap <silent> <C-w>d <Cmd>vsplit<CR><Cmd>call <SID>GoToDefinition()<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" NOTE: `gr` conflicts with ReplaceWithRegister
"nmap <silent> gr <Plug>(coc-references)
nmap <silent> gR <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
call MapKey('<M-c>n', '<Plug>(coc-rename)', ['nmap', 'imap'])

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
call MapKey('<M-f>f', '<Plug>(coc-format-selected)', ['xnoremap'])

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)
call MapSuperKey('.', '<Plug>(coc-fix-current)', ['nmap'])

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" 2022-11-10 huy: <C-S> is to save files so use <C-P> instead
" Use <C-S> for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-P> <Plug>(coc-range-select)
xmap <silent> <C-P> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
call MapKey('<M-f>f', '<Cmd>Format<CR>', ['nmap', 'imap'])

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
call MapKey('<M-f>o', '<Cmd>OR<CR>', ['nmap', 'imap'])

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" My configuration {{{2

let g:coc_global_extensions = [
            \ 'coc-css',
            \ 'coc-diagnostic',
            \ 'coc-eslint',
            \ 'coc-git',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-prettier',
            \ 'coc-pyright',
            \ 'coc-snippets',
            \ 'coc-tsserver',
            \ 'coc-vimlsp'
            \ ]

" Usage: type `:Prettier` to format whole document
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
call MapKey('<M-f>p', '<Cmd>Prettier<CR>', ['nnoremap', 'inoremap'])


""" Use the settings from the coc help

" Use <C-Space> to trigger completion
if exists('g:nvim')
    inoremap <silent><expr> <C-Space> coc#refresh()
else
    " vim can't handle <C-Space>
    inoremap <silent><expr> <C-@> coc#refresh()
endif

" 2024-03-29 This TAB conflicts with GitHub Copilot
" Map <tab> for trigger completion, completion confirm, snippet expand and jump like VSCode:
inoremap <silent><expr> <Tab>
    \ coc#pum#visible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ?
    \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()

" Also, use <C-j> and <C-k> to work like <C-n> and <C-p>
imap <silent><expr> <C-j>
    \ coc#pum#visible() ? "\<C-n>" :
    \ coc#refresh()
" NOTE: Default mapping for <C-k> would normally be defined in init.mappings-emulation for killing the rest of line
imap <silent><expr> <C-k>
    \ coc#pum#visible() ? "\<C-p>":
    \ "\<C-o>D"


" Use <CR> to accept choice instead of <C-y>
inoremap <expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"


let g:coc_snippet_next = '<tab>'

" Use Shift+Esc to dismiss the completion menu
inoremap <expr> <S-Esc> coc#pum#cancel()

" For vim, I'm apparently supposed to do handle the linking myself
" https://github.com/neoclide/coc.nvim/issues/4081
if !exists('g:nvim')
    function! s:LinkCocMenuHighlights()
        hi! link CocMenuSel PMenuSel
        hi! link CocSearch Identifier
    endfunction
    " HACK: something's clearing the highlights for some reason, and I can't figure out
    " why my additions in init.color.vim aren't sufficient
    autocmd BufWinEnter * call timer_start(1, {-> s:LinkCocMenuHighlights()})
endif
