""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Init {{{1

" These might be more convenient than the default vim-surround
" Source: https://www.reddit.com/r/vim/comments/yporwp/my_anal_vimsurround_alternative/

" Chose lowercase `s` for most common operation
nmap <silent> ys( viWS(
nmap <silent> ys) viWS)
nmap <silent> ys[ viWS[
nmap <silent> ys] viWS]
nmap <silent> ys{ viWS{
nmap <silent> ys} viWS}
nmap <silent> ys< viWS<
nmap <silent> ys> viWS>
nmap <silent> ys" viWS"
nmap <silent> ys' viWS'
" Some markdown ones
nmap <silent> ys` viWS`
nmap <silent> ys_ viWS_
nmap <silent> ys* viWS*gvS*
nmap <silent> ys= viWS=gvS=
nmap <silent> ysw viWS]gvS]

" Chose uppercase `S` for most common operation, which matches
" vim-surround's visual-mode `S`
nmap <silent> yS( viwS(
nmap <silent> yS) viwS)
nmap <silent> yS[ viwS[
nmap <silent> yS] viwS]
nmap <silent> yS{ viwS{
nmap <silent> yS} viwS}
nmap <silent> yS< viwS<
nmap <silent> yS> viwS>
nmap <silent> yS" viwS"
nmap <silent> yS' viwS'
" Some markdown ones
nmap <silent> yS` viwS`
nmap <silent> yS_ viwS_
nmap <silent> yS* viwS*gvS*
nmap <silent> yS= viwS=gvS=
nmap <silent> ySw viwS]gvS]

vmap <silent> s* S*gvS*
vmap <silent> s= S=gvS=
vmap <silent> sw S]gvS]
