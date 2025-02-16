""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/esm7/obsidian-vimrc-support
"
" TIP: to list all Obsidian commands, run `:obcommand` and go to JS console.

" Neovim mappings
" FIXME 2024-02-15: doesn't work
"map <C-l> :nohl<CR>

" Have j and k navigate visual lines rather than logical ones
map <Down> gj
map <Up> gk
" FIXME 2024-02-15: don't work
"imap <Down> <C-o>gj
"imap <Up> <C-o>gk

" Interestingly, this works better than in vim at the beginning of the line
imap <C-s> <Esc>hxpka

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
map <C-o> :back<CR>
exmap forward obcommand app:go-forward
map <C-i> :forward<CR>

" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap za :togglefold<CR>
exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall<CR>
exmap foldall obcommand editor:fold-all
nmap zM :foldall<CR>

" Space must first be unbound
unmap <Space>
nmap <Space><Space> :togglefold<CR>

exmap tabnext obcommand workspace:next-tab
nmap gt :tabnext<CR>
exmap tabprev obcommand workspace:previous-tab
nmap gT :tabprev<CR>


exmap FollowLink obcommand editor:follow-link
nmap gx :FollowLink

" https://forum.obsidian.md/t/vim-o-and-o-dont-respect-current-context/48232/3
" XXX Only works for CM5
"exmap NewlineAndIndent cmcommand newlineAndIndent
"nmap o :NewlineAndIndent<CR>

""" vim-surround emulation

" Free up `s` in visual mode
vunmap s
vunmap S

exmap SurroundSquared surround [ ]
" NOTE: ys) doesnt' work
nmap ys] :SurroundSquared<CR>
vmap S] :SurroundSquared<CR>
map µ] :SurroundSquared<CR>

exmap SurroundParens surround ( )
" NOTE: ys) doesnt' work
nmap ys) :SurroundParens<CR>
vmap S) :SurroundParens<CR>
map µ) :SurroundParens<CR>

exmap SurroundAngled surround < >
" NOTE: ys> doesnt' work
nmap ys> :SurroundAngled<CR>
vmap S> :SurroundAngled<CR>
map µ> :SurroundAngled<CR>

exmap SurroundUnderlines surround _ _
" NOTE: ys_ doesnt' work
nmap ys_ :SurroundUnderlines<CR>
vmap S_ :SurroundUnderlines<CR>
map µ_ :SurroundUnderlines<CR>

exmap SurroundDoubleQuotes surround " "
" NOTE: ys" doesnt' work
nmap ys" :SurroundDoubleQuotes<CR>
vmap S" :SurroundDoubleQuotes<CR>
map µ" :SurroundDoubleQuotes<CR>

exmap SurroundSingleQuotes surround ' '
" NOTE: ys' doesnt' work
nmap ys' :SurroundSingleQuotes<CR>
vmap S' :SurroundSingleQuotes<CR>
map µ' :SurroundSingleQuotes<CR>

exmap SurroundBackticks surround ` `
" NOTE: ys` doesnt' work
nmap ys` :SurroundBackticks<CR>
vmap S` :SurroundBackticks<CR>
map µ` :SurroundBackticks<CR>

""" My own surround additions

exmap SurroundStars surround ** **
" NOTE: ys* doesnt' work
nmap ys* :SurroundStars<CR>
vmap s* :SurroundStars<CR>
map µ* :SurroundStars<CR>

exmap SurroundEquals surround == ==
" NOTE: ys= doesnt' work
nmap ys= :SurroundEquals<CR>
vmap s= :SurroundEquals<CR>
map µ= :SurroundEquals<CR>

exmap SurroundWiki surround [[ ]]
" NOTE: ysw doesnt' work
nmap ysw :SurroundWiki<CR>
vmap sw :SurroundWiki<CR>
map µw :SurroundWiki<CR>


""" GUI Emulation mappings

unmap <C-q>
exmap EditVimrc obcommand obsidian-shellcommands:shell-command-d5mbqygiaw
nmap <C-q><C-e> :EditVimrc<CR>

" FIXME: can't get any of the imap mappings to work but I can use the Sequence Hotkeys plugin for
" that
" TODO: when https://github.com/replit/codemirror-vim/pull/60 is merged into Obsidian
"   we have to get rid of the <A-> and re-test

exmap RenameFile obcommand workspace:edit-file-title
nmap çN :RenameFile<CR>

exmap TransformTitlecase obcommand obsidian-editor-shortcuts:transformToTitlecase
nmap çT :TransformTitlecase<CR>
" We have to use jscommand to get the selection
"   See: https://github.com/esm7/obsidian-vimrc-support/issues/99#issuecomment-1128403004
exmap TransformTitlecaseSelection jscommand { editor.setSelections([selection]); this.app.commands.commands['obsidian-editor-shortcuts:transformToTitlecase'].editorCallback(editor) }
vmap çT :TransformTitlecaseSelection<CR>

exmap TableControlBar obcommand table-editor-obsidian:table-control-bar
map µt :TableControlBar<CR>
exmap TableFormat obcommand table-editor-obsidian:format-table
map µf :TableFormat<CR>
exmap TableInsertColumn obcommand table-editor-obsidian:insert-column
map µi :TableInsertColumn<CR>
exmap TableDeleteColumn obcommand table-editor-obsidian:delete-column
map µx :TableDeleteColumn<CR>
exmap TableInsertRow obcommand table-editor-obsidian:insert-row
map µO :TableInsertRow<CR>
exmap TableDeleteRow obcommand table-editor-obsidian:delete-row
map µd :TableDeleteRow<CR>
exmap TableAlignLeft obcommand table-editor-obsidian:left-align-column
map µ<Left> :TableAlignLeft<CR>
exmap TableAlignCenter obcommand table-editor-obsidian:center-align-column
map µ<Down> :TableAlignCenter<CR>
exmap TableAlignRight obcommand table-editor-obsidian:right-align-column
map µ<Right> :TableAlignRight<CR>
exmap ExcelToTable obcommand obsidian-excel-to-markdown-table:excel-to-markdown-table
map µX :ExcelToTable<CR>

" NOTE: we also have the plugin Sequence Hotkeys installed which also implements the same chords.
" 2023-09-04 Why is this one `nmap` and the others `map`?
" And why is there no need for `imap`?
exmap CodeBlock obcommand code-block-from-selection:e3dea0f5-37f2-4d79-ae58-490af3228069
nmap µM :CodeBlock<CR>
exmap CodeBlockSelection jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:e3dea0f5-37f2-4d79-ae58-490af3228069'].callback() }
vmap µM :CodeBlockSelection<CR>
exmap CodeBlockBash obcommand code-block-from-selection:06934685-62e1-4ac2-83c2-b42d2d753d6a
map µB :CodeBlockBash<CR>
exmap CodeBlockSelectionBash jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:06934685-62e1-4ac2-83c2-b42d2d753d6a'].callback() }
vmap µB :CodeBlockSelectionBash<CR>
exmap CodeBlockJS obcommand code-block-from-selection:4ef365c0-8932-4b1e-9947-844a4128ad71
map µJ :CodeBlockJS<CR>
exmap CodeBlockSelectionJS jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:4ef365c0-8932-4b1e-9947-844a4128ad71'].callback() }
vmap µJ :CodeBlockSelectionJS<CR>
exmap CodeBlockPython obcommand code-block-from-selection:f8b19c3a-9b67-428d-a88b-892811f5707a
map µP :CodeBlockPython<CR>
exmap CodeBlockSelectionPython jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:f8b19c3a-9b67-428d-a88b-892811f5707a'].callback() }
vmap µP :CodeBlockSelectionPython<CR>
exmap CodeBlockShell obcommand code-block-from-selection:e4a96b24-7cf7-4c34-95e6-30578c8222ce
map µS :CodeBlockShell<CR>
exmap CodeBlockSelectionShell jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:e4a96b24-7cf7-4c34-95e6-30578c8222ce'].callback() }
vmap µS :CodeBlockSelectionShell<CR>
exmap CodeBlockPowershell obcommand code-block-from-selection:a5afb22c-5d9f-416e-8a43-9ae4a1497bdd
map µW :CodeBlockPowershell<CR>
exmap CodeBlockSelectionPowershell jscommand { editor.setSelections([selection]); this.app.commands.commands['code-block-from-selection:a5afb22c-5d9f-416e-8a43-9ae4a1497bdd'].callback() }
vmap µW :CodeBlockSelectionPowershell<CR>

exmap SearchInternet obcommand search-on-internet:search-on-internet
map øw :SearchInternet<CR>

exmap OpenDefaultApp obcommand open-with-default-app:open
nmap øo :OpenDefaultApp<CR>
exmap RevealInFinder obcommand open-with:show-file-in-explorer
nmap øf :RevealInFinder<CR>
exmap RevealInTerminal obcommand obsidian-shellcommands:shell-command-v6sx70npxw
nmap øt :RevealInTerminal<CR>
exmap OpenVSCode obcommand open-vscode:open-vscode-via-url
nmap øc :OpenVSCode<CR>
exmap OpenMacVim obcommand open-with:open-file-with-macvim
nmap øv :OpenMacVim<CR>
exmap OpenVimR obcommand open-with:open-file-with-vimr
nmap øV :OpenVimR<CR>
exmap OpenMarkText obcommand open-with:open-file-with-marktext
nmap øm :OpenMarkText<CR>
exmap OpenMacDown obcommand open-with:open-file-with-macdown
nmap øM :OpenMacDown<CR>
" XXX: These don't work when we have an image open since Vim mode isn't active. Use Sequence Hotkeys.
exmap OpenCleanShot obcommand open-with:open-file-with-cleanshotx
nmap øx :OpenCleanShot<CR>
exmap OpenPreview obcommand open-with:open-file-with-preview
nmap øu :OpenPreview<CR>

exmap SwitchTheme obcommand theme:switch
nmap ßc :SwitchTheme<CR>
exmap SwitchThemeDark obcommand theme:use-dark
nmap ßb :SwitchThemeDark<CR>
exmap SwitchThemeLight obcommand theme:use-light
nmap ßB :SwitchThemeLight<CR>

exmap ToggleWhitespace obcommand control-characters:toggle
nmap ß<Space> :ToggleWhitespace<CR>

exmap ToggleBacklinks obcommand backlink:toggle-backlinks-in-document
map ß/ :ToggleBacklinks<CR>

exmap GitOpenView obcommand obsidian-git:open-git-view
map ©© :GitOpenView<CR>
exmap GitDiff obcommand obsidian-git:open-diff-view
map ©d :GitDiff<CR>
exmap GitBackupAndClose obcommand obsidian-git:backup-and-close
map ©u :GitBackupAndClose<CR>
exmap GitCommit obcommand obsidian-git:commit
map ©Ç :GitCommit<CR>
exmap GitCommitStaged obcommand obsidian-git:commit-staged
map ©c :GitCommitStaged<CR>
exmap GitListChangedFiles obcommand obsidian-git:list-changed-files
map ©t :GitListChangedFiles<CR>
exmap GitPull obcommand obsidian-git:pull
map ©j :GitPull<CR>
exmap GitPush obcommand obsidian-git:push
map ©k :GitPush<CR>
exmap GitStageFile obcommand obsidian-git:stage-current-file
map ©a :GitStageFile<CR>
exmap GitUnstageFile obcommand obsidian-git:unstage-current-file
map ©A :GitUnstageFile<CR>
exmap GitViewFileOnRemote obcommand obsidian-git:view-file-on-github
map ©o :GitViewFileOnRemote<CR>
exmap GitViewHistoryOnRemote obcommand obsidian-git:view-history-on-github
map ©h :GitViewHistoryOnRemote<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smarter o and O (inserting prefix for markdown lists)
" Source: https://forum.obsidian.md/t/vim-o-and-o-should-respect-current-context/48386/5?u=obsequious

exmap blankBelow obcommand obsidian-editor-shortcuts:insertLineBelow
exmap blankAbove obcommand obsidian-editor-shortcuts:insertLineAbove
nmap o :blankBelow<CR>i
nmap O :blankAbove<CR>i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/esm7/obsidian-vimrc-support/blob/master/JsSnippets.md

" 2024-10-04 deprecated by https://github.com/esm7/obsidian-vimrc-support/pull/222
"exmap nextHeading jsfile /.obsidian/mdHelpers.js {jumpHeading(true)}
"exmap prevHeading jsfile /.obsidian/mdHelpers.js {jumpHeading(false)}
"nmap ]] :nextHeading<CR>
"nmap [[ :prevHeading<CR>


" Disabled because of lots of problems: https://github.com/hhhapz/improved-obsidian-vimcursor/issues/1
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " https://github.com/hhhapz/improved-obsidian-vimcursor
" "
" " 2022-02-16 Bug with LivePreview
" "nmap 0 :g0<CR>
" "nmap $ :gDollar<CR>
" nmap [[ :pHead<CR>
" nmap ]] :nHead<CR>
"
" vmap j gj
" vmap k gk

