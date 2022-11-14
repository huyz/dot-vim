""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/esm7/obsidian-vimrc-support

" Neovim mappings
map <C-L> :nohl

" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
" Quickly remove search highlights
nmap <Esc>u :nohl

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

" Emulate Tab Switching https://vimhelp.org/tabpage.txt.html#gt
" requires Cycle Through Panes Plugins https://obsidian.md/plugins?id=cycle-through-panes
exmap tabnext obcommand cycle-through-panes:cycle-through-panes
map gt :tabnext
exmap tabprev obcommand cycle-through-panes:cycle-through-panes-reverse
map gT :tabprev

exmap FollowLink obcommand editor:follow-link
nmap gx :FollowLink

exmap SurroundWiki surround [[ ]]
" NOTE: ysw doesnt' work
map ysw :SurroundWiki
map <A-µ>w :SurroundWiki

exmap SurroundParens surround ( )
" NOTE: ys) doesnt' work
map ys) :SurroundParens
map <A-µ>) :SurroundParens


""" GUI Emulation mappings


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
exmap OpenCleanShot obcommand open-with:open-file-with-cleanshot x
nmap <A-ø>x :OpenCleanShot
"
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


Available commands: editor:save-file
editor:follow-link
editor:open-link-in-new-leaf
editor:open-link-in-new-split
editor:open-link-in-new-window
editor:focus-top
editor:focus-bottom
editor:focus-left
editor:focus-right
workspace:toggle-pin
workspace:split-vertical
workspace:split-horizontal
workspace:toggle-stacked-tabs
workspace:edit-file-title
workspace:copy-path
workspace:copy-url
workspace:undo-close-pane
workspace:export-pdf
editor:rename-heading
workspace:open-in-new-window
workspace:move-to-new-window
workspace:next-tab
workspace:goto-tab-1
workspace:goto-tab-2
workspace:goto-tab-3
workspace:goto-tab-4
workspace:goto-tab-5
workspace:goto-tab-6
workspace:goto-tab-7
workspace:goto-tab-8
workspace:goto-last-tab
workspace:previous-tab
workspace:new-tab
url-into-selection:paste-url-into-selection
cycle-through-panes:cycle-through-panes
cycle-through-panes:cycle-through-panes-reverse
cycle-through-panes:cycle-through-panes-add-view
cycle-through-panes:cycle-through-panes-remove-view
cycle-through-panes:focus-on-last-active-pane
open-vscode:open-vscode
open-vscode:open-vscode-via-url
nldates-obsidian:nlp-dates
nldates-obsidian:nlp-dates-link
nldates-obsidian:nlp-date-clean
nldates-obsidian:nlp-parse-time
nldates-obsidian:nlp-now
nldates-obsidian:nlp-today
nldates-obsidian:nlp-time
nldates-obsidian:nlp-picker
things-logbook:sync-things-logbook
obsidian-auto-link-title:auto-link-title-paste
obsidian-auto-link-title:enhance-url-with-title
number-headings-obsidian:number-headings-with-options
number-headings-obsidian:number-headings
number-headings-obsidian:remove-number-headings
number-headings-obsidian:save-settings-to-front-matter
obsidian-shortcuts-for-starred-files:open-file-1
obsidian-shortcuts-for-starred-files:open-file-2
obsidian-shortcuts-for-starred-files:open-file-3
obsidian-shortcuts-for-starred-files:open-file-4
obsidian-shortcuts-for-starred-files:open-file-5
obsidian-shortcuts-for-starred-files:open-file-6
obsidian-shortcuts-for-starred-files:open-file-7
obsidian-shortcuts-for-starred-files:open-file-8
obsidian-shortcuts-for-starred-files:open-file-9
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-1
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-2
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-3
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-4
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-5
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-6
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-7
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-8
obsidian-shortcuts-for-starred-files:open-file-in-new-pane-9
wikilinks-to-mdlinks-obsidian:toggle-wiki-md-links
table-editor-obsidian:next-row
table-editor-obsidian:next-cell
table-editor-obsidian:previous-cell
table-editor-obsidian:format-table
table-editor-obsidian:format-all-tables
table-editor-obsidian:insert-column
table-editor-obsidian:insert-row
table-editor-obsidian:escape-table
table-editor-obsidian:move-column-left
table-editor-obsidian:move-column-right
table-editor-obsidian:move-row-up
table-editor-obsidian:move-row-down
table-editor-obsidian:delete-column
table-editor-obsidian:delete-row
table-editor-obsidian:sort-rows-ascending
table-editor-obsidian:sort-rows-descending
table-editor-obsidian:evaluate-formulas
table-editor-obsidian:table-control-bar
calendar:show-calendar-view
calendar:open-weekly-note
calendar:reveal-active-note
search-on-internet:search-on-internet
extract-url:extract-url
extract-url:extract-title-from-url
extract-url:import-url
extract-url:archive-url
obsidian-advanced-uri:copy-uri-current-file
obsidian-advanced-uri:copy-uri-current-file-simple
obsidian-advanced-uri:copy-uri-daily
obsidian-advanced-uri:copy-uri-search-and-replace
obsidian-advanced-uri:copy-uri-command
code-block-from-selection:e3dea0f5-37f2-4d79-ae58-490af3228069
code-block-from-selection:06934685-62e1-4ac2-83c2-b42d2d753d6a
code-block-from-selection:4ef365c0-8932-4b1e-9947-844a4128ad71
code-block-from-selection:f8b19c3a-9b67-428d-a88b-892811f5707a
code-block-from-selection:e4a96b24-7cf7-4c34-95e6-30578c8222ce
mrj-jump-to-link:activate-jump-to-link
mrj-jump-to-link:activate-jump-to-anywhere
mrj-jump-to-link:activate-lightspeed-jump
dataview:dataview-force-refresh-views
dataview:dataview-drop-cache
obsidian-linter:lint-file
obsidian-linter:lint-all-files
obsidian-linter:lint-all-files-in-folder
obsidian-linter:paste-as-plain-text
note-refactor-obsidian:app:extract-selection-first-line
note-refactor-obsidian:app:extract-selection-content-only
note-refactor-obsidian:app:extract-selection-autogenerate-name
note-refactor-obsidian:app:split-note-first-line
note-refactor-obsidian:app:split-note-content-only
note-refactor-obsidian:app:split-note-by-heading-h1
note-refactor-obsidian:app:split-note-by-heading-h2
note-refactor-obsidian:app:split-note-by-heading-h3
obsidian42-text-transporter:obsidian42-text-transporter-combinedCommands
obsidian42-text-transporter:obsidian42-text-transporter-QC
obsidian42-text-transporter:obsidian42-text-transporter-SB
obsidian42-text-transporter:obsidian42-text-transporter-BP
obsidian42-text-transporter:obsidian42-text-transporter-BN
obsidian42-text-transporter:obsidian42-text-transporter-SP
obsidian42-text-transporter:obsidian42-text-transporter-SN
obsidian42-text-transporter:obsidian42-text-transporter-RLT
obsidian42-text-transporter:obsidian42-text-transporter-RLA
obsidian42-text-transporter:obsidian42-text-transporter-CC
obsidian42-text-transporter:obsidian42-text-transporter-CA
obsidian42-text-transporter:obsidian42-text-transporter-CLT
obsidian42-text-transporter:obsidian42-text-transporter-PLT
obsidian42-text-transporter:obsidian42-text-transporter-PLB
obsidian42-text-transporter:obsidian42-text-transporter-SLF
obsidian42-text-transporter:obsidian42-text-transporter-SLC
obsidian42-text-transporter:obsidian42-text-transporter-CLF
obsidian42-text-transporter:obsidian42-text-transporter-LLF
obsidian42-text-transporter:obsidian42-text-transporter-LLB
obsidian42-text-transporter:obsidian42-text-transporter-BA
obsidian42-text-transporter:obsidian42-text-transporter-BO
obsidian42-text-transporter:obsidian42-text-transporter-BR
folder-note-core:make-doc-folder-note
folder-note-core:link-to-parent-folder
folder-note-core:delete-linked-folder
folder-note-core:delete-with-linked-folder
alx-folder-note:set-folder-icon
templater-obsidian:insert-templater
templater-obsidian:replace-in-file-templater
templater-obsidian:jump-to-next-cursor-location
templater-obsidian:create-new-note-from-template
templater-obsidian:_templates/Templater/note.md
templater-obsidian:_templates/Templater/heading_ insert parent.md
templater-obsidian:_templates/Templater/heading_ insert sibling.md
templater-obsidian:_templates/Templater/heading_ insert child.md
obsidian-hover-editor:bounce-popovers
obsidian-hover-editor:open-new-popover
obsidian-hover-editor:open-link-in-new-popover
obsidian-hover-editor:open-current-file-in-new-popover
obsidian-hover-editor:convert-active-pane-to-popover
obsidian-hover-editor:dock-active-popover-to-workspace
obsidian-hover-editor:restore-active-popover
obsidian-hover-editor:minimize-active-popover
obsidian-hover-editor:snap-active-popover-to-left
obsidian-hover-editor:snap-active-popover-to-right
obsidian-hover-editor:snap-active-popover-to-viewport
find-unlinked-files:find-unlinked-files
find-unlinked-files:find-unresolved-link
find-unlinked-files:delete-unlinked-files
find-unlinked-files:create-files-of-broken-links
find-unlinked-files:find-files-without-tags
find-unlinked-files:find-empty-files
find-unlinked-files:delete-empty-files
obsidian-link-embed:embed-link
obsidian-link-embed:embed-link-jsonlink
obsidian-link-embed:embed-link-microlink
obsidian-link-embed:embed-link-iframely
open-with:copy-absolute-file-path
open-with:show-file-in-explorer
open-with:open-file-with-macvim
open-with:open-file-with-vimr
open-with:open-file-with-macdown
open-with:open-file-with-marktext
open-with:open-file-with-cleanshot x
open-with:open-file-with-neovide
open-with:open-file-with-marked
highlightr-plugin:highlighter-plugin-menu
highlightr-plugin:Pink
highlightr-plugin:unhighlight
highlightr-plugin:Red
highlightr-plugin:Orange
highlightr-plugin:Yellow
highlightr-plugin:Green
highlightr-plugin:Cyan
highlightr-plugin:Blue
highlightr-plugin:Purple
highlightr-plugin:Grey
obsidian-checklist-plugin:show-checklist-view
obsidian-checklist-plugin:refresh-checklist-view
obsidian-style-settings:show-style-settings-leaf
obsidian-zotero-desktop-connector:zdc-insert-notes
obsidian-zotero-desktop-connector:zdc-import-notes
obsidian-zotero-desktop-connector:show-zotero-debug-view
obsidian-tracker:add-line-chart-tracker
obsidian-tracker:add-bar-chart-tracker
obsidian-tracker:add-summary-tracker
recent-files-obsidian:recent-files-open
obsidian-file-info-plugin:form-info-show-window
pane-relief:swap-prev
pane-relief:swap-next
pane-relief:go-prev
pane-relief:go-next
pane-relief:win-prev
pane-relief:win-next
pane-relief:go-1st
pane-relief:go-2nd
pane-relief:go-3rd
pane-relief:go-4th
pane-relief:go-5th
pane-relief:go-6th
pane-relief:go-7th
pane-relief:go-8th
pane-relief:go-last
pane-relief:win-1st
pane-relief:win-2nd
pane-relief:win-3rd
pane-relief:win-4th
pane-relief:win-5th
pane-relief:win-6th
pane-relief:win-7th
pane-relief:win-8th
pane-relief:win-last
pane-relief:put-1st
pane-relief:put-2nd
pane-relief:put-3rd
pane-relief:put-4th
pane-relief:put-5th
pane-relief:put-6th
pane-relief:put-7th
pane-relief:put-8th
pane-relief:put-last
pane-relief:maximize
pane-relief:ordered-close
pane-relief:open-new-window
pane-relief:toggle-sliding
pane-relief:focus-lock
darlal-switcher-plus:switcher-plus:open
darlal-switcher-plus:switcher-plus:open-editors
darlal-switcher-plus:switcher-plus:open-symbols
darlal-switcher-plus:switcher-plus:open-workspaces
darlal-switcher-plus:switcher-plus:open-headings
darlal-switcher-plus:switcher-plus:open-starred
darlal-switcher-plus:switcher-plus:open-commands
darlal-switcher-plus:switcher-plus:open-related-items
obsidian-better-internal-link-inserter:use-selected-word-as-alias
obsidian42-brat:BRAT-AddBetaPlugin
obsidian42-brat:BRAT-AddBetaPluginWithFrozenVersion
obsidian42-brat:BRAT-checkForUpdatesAndUpdate
obsidian42-brat:BRAT-checkForUpdatesAndDontUpdate
obsidian42-brat:BRAT-updateOnePlugin
obsidian42-brat:BRAT-restartPlugin
obsidian42-brat:BRAT-disablePlugin
obsidian42-brat:BRAT-enablePlugin
obsidian42-brat:BRAT-openGitHubZRepository
obsidian42-brat:BRAT-openGitHubRepoTheme
obsidian42-brat:BRAT-opentPluginSettings
obsidian42-brat:BRAT-GrabCommunityTheme
obsidian42-brat:BRAT-GrabBetaTheme
obsidian42-brat:BRAT-updateBetaThemes
obsidian42-brat:BRAT-switchTheme
obsidian42-brat:BRAT-allCommands
obsidian-tomorrows-daily-note:create-tomorrows-daily-note
blockquote-levels:blockquote-levels-increase
blockquote-levels:blockquote-levels-decrease
obsidian-tweaks:select-line
obsidian-tweaks:select-word
obsidian-tweaks:better-formatting-bold-underscore
obsidian-tweaks:better-formatting-bold-asterisk
obsidian-tweaks:better-formatting-italics-underscore
obsidian-tweaks:better-formatting-italics-asterisk
obsidian-tweaks:better-formatting-code
obsidian-tweaks:better-formatting-comment
obsidian-tweaks:better-formatting-highlight
obsidian-tweaks:better-formatting-strikethrough
obsidian-tweaks:better-formatting-math-inline
obsidian-tweaks:better-formatting-math-block
obsidian-tweaks:move-left
obsidian-tweaks:move-right
obsidian-tweaks:copy-line-up
obsidian-tweaks:copy-line-down
obsidian-tweaks:copy-line-left
obsidian-tweaks:copy-line-right
obsidian-tweaks:toggle-heading-1
obsidian-tweaks:toggle-heading-2
obsidian-tweaks:toggle-heading-3
obsidian-tweaks:toggle-heading-4
obsidian-tweaks:toggle-heading-5
obsidian-tweaks:toggle-heading-6
obsidian-tweaks:new-adjacent-file
obsidian-tweaks:duplicate-file
obsidian-heading-shifter:apply-heading0
obsidian-heading-shifter:apply-heading1
obsidian-heading-shifter:apply-heading2
obsidian-heading-shifter:apply-heading3
obsidian-heading-shifter:apply-heading4
obsidian-heading-shifter:apply-heading5
obsidian-heading-shifter:apply-heading6
obsidian-heading-shifter:increase-heading
obsidian-heading-shifter:decrease-heading
advanced-cursors:open-regex-match-modal
advanced-cursors:move-to-next-match
advanced-cursors:move-to-previous-match
advanced-cursors:add-next-match-to-selections
advanced-cursors:add-prev-match-to-selections
advanced-cursors:copy-line-up
advanced-cursors:copy-line-down
advanced-cursors:add-cursor-above
advanced-cursors:add-cursor-below
advanced-cursors:write-incrementing-i
advanced-cursors:open-savedQ-view
obsidian-editor-shortcuts:insertLineAbove
obsidian-editor-shortcuts:insertLineBelow
obsidian-editor-shortcuts:deleteLine
obsidian-editor-shortcuts:deleteToStartOfLine
obsidian-editor-shortcuts:deleteToEndOfLine
obsidian-editor-shortcuts:joinLines
obsidian-editor-shortcuts:duplicateLine
obsidian-editor-shortcuts:copyLineUp
obsidian-editor-shortcuts:copyLineDown
obsidian-editor-shortcuts:selectWordOrNextOccurrence
obsidian-editor-shortcuts:selectAllOccurrences
obsidian-editor-shortcuts:selectLine
obsidian-editor-shortcuts:addCursorsToSelectionEnds
obsidian-editor-shortcuts:goToLineStart
obsidian-editor-shortcuts:goToLineEnd
obsidian-editor-shortcuts:goToNextLine
obsidian-editor-shortcuts:goToPrevLine
obsidian-editor-shortcuts:goToNextChar
obsidian-editor-shortcuts:goToPrevChar
obsidian-editor-shortcuts:transformToUppercase
obsidian-editor-shortcuts:transformToLowercase
obsidian-editor-shortcuts:transformToTitlecase
obsidian-editor-shortcuts:expandSelectionToBrackets
obsidian-editor-shortcuts:expandSelectionToQuotes
obsidian-editor-shortcuts:expandSelectionToQuotesOrBrackets
obsidian-editor-shortcuts:goToNextHeading
obsidian-editor-shortcuts:goToPrevHeading
obsidian-collapse-all-plugin:collapse-all-collapse
obsidian-collapse-all-plugin:collapse-all-expand
obsidian-shellcommands:shell-command-v6sx70npxw
omnisearch:show-modal
omnisearch:show-modal-infile
markdown-table-editor:markdown-table-editor-open-vertical
markdown-table-editor:markdown-table-editor-open-horizontal
markdown-table-editor:markdown-table-editor-select-table-content
markdown-table-editor:markdown-table-editor-open-in-popover
obsidian-paste-image-rename:batch-rename-embeded-files
obsidian-paste-image-rename:batch-rename-all-images
obsidian-quiet-outline:quiet-outline
obsidian-quiet-outline:quiet-outline-reset
obsidian-quiet-outline:quiet-outline-focus-input
obsidian-quiet-outline:quiet-outline-copy-as-text
obsidian-zoom:zoom-in
obsidian-zoom:zoom-out
obsidian42-strange-new-worlds:SNW-ToggleActiveState
quick-explorer:browse-vault
quick-explorer:browse-current
quick-explorer:go-next
quick-explorer:go-prev
quick-explorer:go-first
quick-explorer:go-last
obsidian-smarter-md-hotkeys:smarter-asterisk-bold
obsidian-smarter-md-hotkeys:smarter-underscore-bold
obsidian-smarter-md-hotkeys:smarter-asterisk-italics
obsidian-smarter-md-hotkeys:smarter-underscore-italics
obsidian-smarter-md-hotkeys:smarter-comments
obsidian-smarter-md-hotkeys:smarter-html-comments
obsidian-smarter-md-hotkeys:smarter-inline-code
obsidian-smarter-md-hotkeys:smarter-highlight
obsidian-smarter-md-hotkeys:smarter-bold-highlight
obsidian-smarter-md-hotkeys:smarter-italics-highlight
obsidian-smarter-md-hotkeys:smarter-strikethrough
obsidian-smarter-md-hotkeys:smarter-wikilink
obsidian-smarter-md-hotkeys:smarter-wikilink-heading
obsidian-smarter-md-hotkeys:smarter-md-link
obsidian-smarter-md-hotkeys:smarter-math
obsidian-smarter-md-hotkeys:smarter-callout-label
obsidian-smarter-md-hotkeys:smarter-quotation-marks
obsidian-smarter-md-hotkeys:smarter-single-quotation-marks
obsidian-smarter-md-hotkeys:smarter-round-brackets
obsidian-smarter-md-hotkeys:smarter-square-brackets
obsidian-smarter-md-hotkeys:smarter-curly-brackets
obsidian-smarter-md-hotkeys:smarter-delete
obsidian-smarter-md-hotkeys:smarter-upper-lower
obsidian-smarter-md-hotkeys:smarter-insert-new-line
obsidian-smarter-md-hotkeys:smarter-toggle-heading
obsidian-smarter-md-hotkeys:smarter-toggle-heading-reverse
obsidian-smarter-md-hotkeys:smarter-delete-current-file
obsidian-smarter-md-hotkeys:smarter-copy-path
obsidian-smarter-md-hotkeys:toggle-line-numbers
obsidian-smarter-md-hotkeys:toggle-readable-line-length
obsidian-smarter-md-hotkeys:smarter-copy-file-name
obsidian-smarter-md-hotkeys:hide-notice
obsidian-better-command-palette:obsidian-better-command-palette-macro-0
obsidian-better-command-palette:obsidian-better-command-palette-macro-1
obsidian-better-command-palette:open-better-commmand-palette
obsidian-better-command-palette:open-better-commmand-palette-file-search
obsidian-better-command-palette:open-better-commmand-palette-tag-search
obsidian-things-link:create-things-project
obsidian-things-link:create-things-task
obsidian-things3-sync:create-things-todo
obsidian-things3-sync:toggle-things-todo
dbfolder:create-new-database-folder
obsidian-columns:insert-column-wrapper
obsidian-columns:insert-column
metadata-menu:update_formulas
metaedit:metaEditRun
obsidian-tasks-plugin:edit-task
obsidian-tasks-plugin:toggle-done
meld-calc:encrypt-calc
obsidian-numerals:reset-numerals-settings
control-characters:toggle
obsidian-git:edit-gitignore
obsidian-git:open-git-view
obsidian-git:open-diff-view
obsidian-git:view-file-on-github
obsidian-git:view-history-on-github
obsidian-git:pull
obsidian-git:add-to-gitignore
obsidian-git:push
obsidian-git:backup-and-close
obsidian-git:commit-push-specified-message
obsidian-git:commit
obsidian-git:commit-specified-message
obsidian-git:commit-staged
obsidian-git:commit-staged-specified-message
obsidian-git:push2
obsidian-git:stage-current-file
obsidian-git:unstage-current-file
obsidian-git:edit-remotes
obsidian-git:remove-remote
obsidian-git:delete-repo
obsidian-git:init-repo
obsidian-git:clone-repo
obsidian-git:list-changed-files
obsidian-git:switch-branch
obsidian-git:create-branch
obsidian-git:delete-branch
meld-encrypt:meld-encrypt-create-new-note
meld-encrypt:meld-encrypt
meld-encrypt:meld-encrypt-in-place
meld-encrypt:meld-encrypt-note
app:go-back
app:go-forward
app:open-vault
theme:use-dark
theme:use-light
theme:switch
app:open-settings
app:show-release-notes
markdown:toggle-preview
workspace:close
workspace:close-others
app:delete-file
app:toggle-left-sidebar
app:toggle-right-sidebar
app:toggle-default-new-pane-mode
app:open-help
app:reload
app:show-debug-info
window:toggle-always-on-top
window:zoom-in
window:zoom-out
window:reset-zoom
file-explorer:new-file
file-explorer:new-file-in-new-pane
open-with-default-app:open
file-explorer:move-file
open-with-default-app:show
editor:open-search
editor:open-search-replace
editor:focus
editor:toggle-fold
editor:fold-all
editor:unfold-all
editor:fold-less
editor:fold-more
editor:insert-wikilink
editor:insert-embed
editor:insert-link
editor:insert-tag
editor:set-heading
editor:set-heading-0
editor:set-heading-1
editor:set-heading-2
editor:set-heading-3
editor:set-heading-4
editor:set-heading-5
editor:set-heading-6
editor:toggle-bold
editor:toggle-italics
editor:toggle-strikethrough
editor:toggle-highlight
editor:toggle-code
editor:toggle-blockquote
editor:toggle-comments
editor:toggle-bullet-list
editor:toggle-numbered-list
editor:toggle-checklist-status
editor:cycle-list-checklist
editor:insert-callout
editor:swap-line-up
editor:swap-line-down
editor:attach-file
editor:delete-paragraph
editor:toggle-spellcheck
editor:context-menu
file-explorer:open
file-explorer:reveal-active-file
global-search:open
switcher:open
graph:open
graph:open-local
graph:animate
backlink:open
backlink:open-backlinks
backlink:toggle-backlinks-in-document
outgoing-links:open
outgoing-links:open-for-current
tag-pane:open
daily-notes
daily-notes:goto-prev
daily-notes:goto-next
insert-template
insert-current-date
insert-current-time
note-composer:merge-file
note-composer:split-file
note-composer:extract-heading
command-palette:open
starred:open
starred:star-current-file
outline:open
outline:open-for-current
audio-recorder:start
audio-recorder:stop
workspaces:load
workspaces:save-and-load
workspaces:open-modal
file-recovery:open
editor:toggle-source
hotkey-helper:open-plugins
hotkey-helper:browse-plugins
hotkey-helper:open-settings
hotkey-helper:open-hotkeys
metadata-menu:field_options
metadata-menu:insert_field_at_cursor
metadata-menu:field_at_cursor_options
metadata-menu:insert_missing_fields
obsidian-annotator:toggle-annotation-mode
ava:ava-autocompletion-enable
ava:ava-generate-image
