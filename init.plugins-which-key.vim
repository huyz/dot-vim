""" which-key {{{1

set timeoutlen=500

"nnoremap <silent> <Leader> <Cmd>WhichKey '\\'<CR>
"vnoremap <silent> <Leader> <Cmd>WhichKey '\\'<CR>
"nnoremap <silent> g <Cmd>WhichKey 'g'<CR>
for letter in ['c', 'f', 'g', 'm', 'o', 'r', 's', 'x']
    exe "call MapKey('<M-" . letter . ">', '<Cmd>WhichKey " . '"M_' . letter . '" ' . "<CR>')"
endfor

function! WhichKeyRegister()
    for letter in ['c', 'f', 'g', 'm', 'o', 'r', 's', 'x']
        exe " call which_key#register('M_" . letter . "', " . '"g:which_key_map_M_' . letter . '")'
    endfor
endfunction
autocmd! User vim-which-key call WhichKeyRegister()

" FIXME: 'T' doesn't work; probably need to create a function.
let g:which_key_map_M_c = {
            \ 'C': ['CamelB', 'Transform to camelCase'],
            \ 'D': ['cr.', 'Transform to dot.case'],
            \ 'K': ['Kebab', 'Transform to kebab-case'],
            \ 'P': ['Camel', 'Transform to PascalCase'],
            \ 'T': ["viW:\<C-u>exe 'normal \\\\<Plug>Titlecase'\<CR>", 'Transform to Title Case'],
            \ 'S': ['Snek', 'Transform to snake_case'],
            \ '_': ['Screm', 'Transform to SCREAM_CASE'],
            \ }
let g:which_key_map_M_x = {
            \ '<M-x>': 'swap words',
            \ }
let g:which_key_map_M_m = {
            \   't': 'enable table mode',
            \ }

