""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Init {{{1

" These might be more convenient than the default vim-surround
" Source: https://www.reddit.com/r/vim/comments/yporwp/my_anal_vimsurround_alternative/

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
nmap <silent> ys* viwS*gvS*
nmap <silent> ys= viwS=gvS=
nmap <silent> ysw viwS]gvS]

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
nmap <silent> yS* viWS*gvS*
nmap <silent> yS= viWS=gvS=
nmap <silent> ySw viWS]gvS]
