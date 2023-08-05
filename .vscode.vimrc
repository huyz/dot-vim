""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" As of 2022-11-17, VSCodeVim only supports mappings in this file
" NOTES:
" - By default, VSCodeVim gives <C-s> and <C-z> to VSCode, but that's easily changed in settings JSON.


" To have most of the same defaults as neovim
" Can't remap `Y` as it's used incredibly often and needs to be pressed reliably
"nnoremap Y y$
nnoremap <C-l> :<C-u>nohl<CR><C-l>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
" 2022-11-18 \V isn't supported yet.
xnoremap * y/<C-r>"<CR>
xnoremap # y?<C-r>"<CR>
nnoremap & :&&<CR>

" Have j and k navigate visual lines rather than logical ones
map <Down> gj
map <Up> gk
imap <Down> <C-o>gj
imap <Up> <C-o>gk

" Doesn't work but could set it in vscode's Keyboard Shortcuts
nnoremap <C-s> :w<CR><C-l>
" Interestingly, this works better than in vim at the beginning of the line
imap <C-s> <Esc>hxpa

" Folding shortcut
nmap <Space><Space> za

" Since vim/vscode steals <C-k> for digraphs, we'll make <C-k><C-k> work like it
inoremap <C-k><C-k> <C-o>D

" 2023-08-05 FIXME: doesn't work so I'm editing keybindings.json instead
inoremap <C-q><C-i> 	 " Inserts a literal tab


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 2022-11-18 Manual inclusion of init.mappings-surround.vim because `source`
" not yet implemented.

" These might be more convenient than the default vim-surround
" Source: https://www.reddit.com/r/vim/comments/yporwp/my_anal_vimsurround_alternative/

nmap <silent> yS( viWS(
nmap <silent> yS) viWS)
nmap <silent> yS[ viWS[
nmap <silent> yS] viWS]
nmap <silent> yS{ viWS{
nmap <silent> yS} viWS}
nmap <silent> yS< viWS<
nmap <silent> yS> viWS>
nmap <silent> yS" viWS"
nmap <silent> yS' viWS'
" Some markdown ones
nmap <silent> yS` viWS`
nmap <silent> yS_ viWS_
" NOTE: these 3 are tested in vim, IdeaVim, and VSCodeVim. Don't use `gv`
nmap <silent> yS* diWi**<C-r>-**<Esc>
nmap <silent> yS= diWi==<C-r>-==<Esc>
nmap <silent> ySw diWi[[<C-r>-]]<Esc>

nmap <silent> ys( viwS(
nmap <silent> ys) viwS)
nmap <silent> ys[ viwS[
nmap <silent> ys] viwS]
nmap <silent> ys{ viwS{
nmap <silent> ys} viwS}
nmap <silent> ys< viwS<
nmap <silent> ys> viwS>
nmap <silent> ys" viwS"
nmap <silent> ys' viwS'
" Some markdown ones
nmap <silent> ys` viwS`
nmap <silent> ys_ viwS_
" NOTE: these 3 are tested in vim, IdeaVim, and VSCodeVim. Don't use `gv`
nmap <silent> ys* diwi**<C-r>-**<Esc>
nmap <silent> ys= diwi==<C-r>-==<Esc>
nmap <silent> ysw diwi[[<C-r>-]]<Esc>

" NOTE: these 3 are tested in vim, IdeaVim, and VSCodeVim. `gv` used in other
" ways would act inconsistently in all 3.
vmap <silent> s* di**<C-r>-**<Esc>gv4l
vmap <silent> s= di==<C-r>-==<Esc>gv4l
vmap <silent> sw di[[<C-r>-]]<Esc>gv4l
