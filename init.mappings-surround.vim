""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Init {{{1

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
