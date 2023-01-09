""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/esm7/obsidian-vimrc-support

" Neovim mappings
" FIXME: doesn't work
map <C-l> :nohl

" Have j and k navigate visual lines rather than logical ones
map <Down> gj
map <Up> gk
imap <Down> <C-o>gj
imap <Up> <C-o>gk

" Interestingly, this works better than in vim at the beginning of the line
imap <C-s> <Esc>hxpa

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
map <C-o> :back
exmap forward obcommand app:go-forward
map <C-i> :forward

" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap za :togglefold
exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall
exmap foldall obcommand editor:fold-all
nmap zM :foldall

" Space must first be unbound
unmap <Space>
nmap <Space><Space> :togglefold

" Emulate Tab Switching https://vimhelp.org/tabpage.txt.html#gt
" requires Cycle Through Panes Plugins https://obsidian.md/plugins?id=cycle-through-panes
exmap tabnext obcommand cycle-through-panes:cycle-through-panes
map gt :tabnext
exmap tabprev obcommand cycle-through-panes:cycle-through-panes-reverse
map gT :tabprev

exmap FollowLink obcommand editor:follow-link
nmap gx :FollowLink

" https://forum.obsidian.md/t/vim-o-and-o-dont-respect-current-context/48232/3
" XXX Only works for CM5
"exmap NewlineAndIndent cmcommand newlineAndIndent
"nmap o :NewlineAndIndent

""" vim-surround emulation

" Free up `s` in visual mode
vunmap s
vunmap S

exmap SurroundSquared surround [ ]
" NOTE: ys) doesnt' work
nmap ys] :SurroundSquared
vmap S] :SurroundSquared
map <A-µ>] :SurroundSquared

exmap SurroundParens surround ( )
" NOTE: ys) doesnt' work
nmap ys) :SurroundParens
vmap S) :SurroundParens
map <A-µ>) :SurroundParens

exmap SurroundAngled surround < >
" NOTE: ys> doesnt' work
nmap ys> :SurroundAngled
map S> :SurroundAngled
map <A-µ>> :SurroundAngled

exmap SurroundUnderlines surround _ _
" NOTE: ys_ doesnt' work
nmap ys_ :SurroundUnderlines
map S_ :SurroundUnderlines
map <A-µ>_ :SurroundUnderlines

exmap SurroundDoubleQuotes surround " "
" NOTE: ys" doesnt' work
nmap ys" :SurroundDoubleQuotes
map S" :SurroundDoubleQuotes
map <A-µ>" :SurroundDoubleQuotes

exmap SurroundSingleQuotes surround ' '
" NOTE: ys' doesnt' work
nmap ys' :SurroundSingleQuotes
map S' :SurroundSingleQuotes
map <A-µ>' :SurroundSingleQuotes

exmap SurroundBackticks surround ` `
" NOTE: ys` doesnt' work
nmap ys` :SurroundBackticks
map S` :SurroundBackticks
map <A-µ>` :SurroundBackticks

""" My own surround additions

exmap SurroundStars surround ** **
" NOTE: ys* doesnt' work
nmap ys* :SurroundStars
vmap s* :SurroundStars
map <A-µ>* :SurroundStars

exmap SurroundEquals surround == ==
" NOTE: ys= doesnt' work
nmap ys= :SurroundEquals
vmap s= :SurroundEquals
map <A-µ>= :SurroundEquals

exmap SurroundWiki surround [[ ]]
" NOTE: ysw doesnt' work
nmap ysw :SurroundWiki
vmap sw :SurroundWiki
map <A-µ>w :SurroundWiki


""" GUI Emulation mappings

unmap <C-q>
exmap EditVimrc obcommand obsidian-shellcommands:shell-command-d5mbqygiaw
nmap <C-q><C-e> :EditVimrc

" FIXME: can't get any of the imap mappings to work but I can use the Sequence Hotkeys plugin for
" that
" TODO: when https://github.com/replit/codemirror-vim/pull/60 is merged into Obsidian
"   we have to get rid of the <A-> and re-test

exmap RenameFile obcommand workspace:edit-file-title
nmap <A-ç>N :RenameFile

exmap TransformTitlecase obcommand obsidian-editor-shortcuts:transformToTitlecase
nmap <A-ç>T :TransformTitlecase
" We have to use jscommand to get the selection
"   See: https://github.com/esm7/obsidian-vimrc-support/issues/99#issuecomment-1128403004
exmap TransformTitlecaseSelection jscommand { editor.setSelections([selection]); this.app.commands.commands['obsidian-editor-shortcuts:transformToTitlecase'].editorCallback(editor) }
vmap <A-ç>T :TransformTitlecaseSelection

exmap TableControlBar obcommand table-editor-obsidian:table-control-bar
map <A-µ>t :TableControlBar
exmap TableFormat obcommand table-editor-obsidian:format-table
map <A-µ>f :TableFormat
exmap TableInsertColumn obcommand table-editor-obsidian:insert-column
map <A-µ>i :TableInsertColumn
exmap TableDeleteColumn obcommand table-editor-obsidian:delete-column
map <A-µ>x :TableDeleteColumn
exmap TableInsertRow obcommand table-editor-obsidian:insert-row
map <A-µ>O :TableInsertRow
exmap TableDeleteRow obcommand table-editor-obsidian:delete-row
map <A-µ>d :TableDeleteRow
exmap TableAlignLeft obcommand table-editor-obsidian:left-align-column
map <A-µ><Left> :TableAlignLeft
exmap TableAlignCenter obcommand table-editor-obsidian:center-align-column
map <A-µ><Down> :TableAlignCenter
exmap TableAlignRight obcommand table-editor-obsidian:right-align-column
map <A-µ><Right> :TableAlignRight
exmap ExcelToTable obcommand obsidian-excel-to-markdown-table:excel-to-markdown-table
map <A-µ>X :ExcelToTable

exmap CodeBlock obcommand code-block-from-selection:e3dea0f5-37f2-4d79-ae58-490af3228069
nmap <A-µ>C :CodeBlock
exmap CodeBlockSelection jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:e3dea0f5-37f2-4d79-ae58-490af3228069'].callback() }
vmap <A-µ>C :CodeBlockSelection
exmap CodeBlockBash obcommand code-block-from-selection:06934685-62e1-4ac2-83c2-b42d2d753d6a
map <A-µ>B :CodeBlockBash
exmap CodeBlockSelectionBash jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:06934685-62e1-4ac2-83c2-b42d2d753d6a'].callback() }
vmap <A-µ>B :CodeBlockSelectionBash
exmap CodeBlockJS obcommand code-block-from-selection:4ef365c0-8932-4b1e-9947-844a4128ad71
map <A-µ>J :CodeBlockJS
exmap CodeBlockSelectionJS jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:4ef365c0-8932-4b1e-9947-844a4128ad71'].callback() }
vmap <A-µ>J :CodeBlockSelectionJS
exmap CodeBlockPython obcommand code-block-from-selection:f8b19c3a-9b67-428d-a88b-892811f5707a
map <A-µ>P :CodeBlockPython
exmap CodeBlockSelectionPython jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:f8b19c3a-9b67-428d-a88b-892811f5707a'].callback() }
vmap <A-µ>P :CodeBlockSelectionPython
exmap CodeBlockShell obcommand code-block-from-selection:e4a96b24-7cf7-4c34-95e6-30578c8222ce
map <A-µ>S :CodeBlockShell
exmap CodeBlockSelectionShell jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:e4a96b24-7cf7-4c34-95e6-30578c8222ce'].callback() }
vmap <A-µ>S :CodeBlockSelectionShell

exmap SearchInternet obcommand search-on-internet:search-on-internet
map <A-ø>w :SearchInternet

exmap OpenDefaultApp obcommand open-with-default-app:open
nmap <A-ø>o :OpenDefaultApp
exmap RevealInFinder obcommand open-with:show-file-in-explorer
nmap <A-ø>f :RevealInFinder
exmap RevealInTerminal obcommand obsidian-shellcommands:shell-command-v6sx70npxw
nmap <A-ø>t :RevealInTerminal
exmap OpenVSCode obcommand open-vscode:open-vscode-via-url
nmap <A-ø>c :OpenVSCode
exmap OpenMacVim obcommand open-with:open-file-with-macvim
nmap <A-ø>v :OpenMacVim
exmap OpenVimR obcommand open-with:open-file-with-vimr
nmap <A-ø>V :OpenVimR
exmap OpenMarkText obcommand open-with:open-file-with-marktext
nmap <A-ø>m :OpenMarkText
exmap OpenMacDown obcommand open-with:open-file-with-macdown
nmap <A-ø>M :OpenMacDown
" XXX: These don't work when we have an image open since Vim mode isn't active. Use Sequence Hotkeys.
exmap OpenCleanShot obcommand open-with:open-file-with-cleanshotx
nmap <A-ø>x :OpenCleanShot
exmap OpenPreview obcommand open-with:open-file-with-preview
nmap <A-ø>u :OpenPreview

exmap SwitchTheme obcommand theme:switch
nmap <A-ß>c :SwitchTheme
exmap SwitchThemeDark obcommand theme:use-dark
nmap <A-ß>b :SwitchThemeDark
exmap SwitchThemeLight obcommand theme:use-light
nmap <A-ß>B :SwitchThemeLight

exmap ToggleWhitespace obcommand control-characters:toggle
nmap <A-ß><Space> :ToggleWhitespace

exmap ToggleBacklinks obcommand backlink:toggle-backlinks-in-document
map <A-ß>/ :ToggleBacklinks

exmap GitOpenView obcommand obsidian-git:open-git-view
map <A-©><A-©> :GitOpenView
exmap GitDiff obcommand obsidian-git:open-diff-view
map <A-©>d :GitDiff
exmap GitBackupAndClose obcommand obsidian-git:backup-and-close
map <A-©>u :GitBackupAndClose
exmap GitCommit obcommand obsidian-git:commit
map <A-©><A-S-Ç> :GitCommit
exmap GitCommitStaged obcommand obsidian-git:commit-staged
map <A-©>c :GitCommitStaged
exmap GitListChangedFiles obcommand obsidian-git:list-changed-files
map <A-©>t :GitListChangedFiles
exmap GitPull obcommand obsidian-git:pull
map <A-©>j :GitPull
exmap GitPush obcommand obsidian-git:push
map <A-©>k :GitPush
exmap GitStageFile obcommand obsidian-git:stage-current-file
map <A-©>a :GitStageFile
exmap GitUnstageFile obcommand obsidian-git:unstage-current-file
map <A-©>A :GitUnstageFile
exmap GitViewFileOnRemote obcommand obsidian-git:view-file-on-github
map <A-©>o :GitViewFileOnRemote
exmap GitViewHistoryOnRemote obcommand obsidian-git:view-history-on-github
map <A-©><A-˙> :GitViewHistoryOnRemote


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smarter o and O (inserting prefix for markdown lists)
" Source: https://forum.obsidian.md/t/vim-o-and-o-should-respect-current-context/48386/5?u=obsequious

exmap blankBelow obcommand obsidian-editor-shortcuts:insertLineBelow
exmap blankAbove obcommand obsidian-editor-shortcuts:insertLineAbove
nmap &a& :blankAbove
nmap &b& :blankBelow
nmap o &b&i
nmap O &a&i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/esm7/obsidian-vimrc-support/blob/master/JsSnippets.md

exmap nextHeading jsfile /.obsidian/mdHelpers.js {jumpHeading(true)}
exmap prevHeading jsfile /.obsidian/mdHelpers.js {jumpHeading(false)}
nmap ]] :nextHeading
nmap [[ :prevHeading


" Disabled because of lots of problems: https://github.com/hhhapz/improved-obsidian-vimcursor/issues/1
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " https://github.com/hhhapz/improved-obsidian-vimcursor
" "
" " 2022-02-16 Bug with LivePreview
" "nmap 0 :g0
" "nmap $ :gDollar
" nmap [[ :pHead
" nmap ]] :nHead
"
" vmap j gj
" vmap k gk

