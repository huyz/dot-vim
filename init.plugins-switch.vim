""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" switch {{{1

" Disable default mapping
let g:switch_mapping = ""

" https://github.com/HiDeoo/toggler-vscode/blob/4b3dcdb8b944aa7d6a63bcaa80d93a746c741f32/src/defaults.json
let s:switch_toggler_vscode_defaults_words =
    \ [
    \   ["absolute", "relative"],
    \   ["high", "low"],
    \   ["horizontal", "vertical"],
    \   ["inner", "outer"],
    \   ["left", "right"],
    \   ["top", "bottom"],
    \
    \   ["black", "white"],
    \   ["gray", "maroon", "red", "purple", "fuchsia", "green", "yellow", "blue", "aqua"],
    \
    \   ["const", "let", "var"],
    \   ["import", "export"],
    \   ["join", "split"],
    \   ["JSON.parse", "JSON.stringify"],
    \   ["parse", "stringify"],
    \   ["pop", "push"],
    \   ["unshift", "shift"],
    \   ["test.only", "test"],
    \
    \   ["onAnimationStart", "onAnimationEnd"],
    \   ["onChange", "onInput", "onSubmit"],
    \   ["onClick", "onDoubleClick"],
    \   ["onCompositionStart", "onCompositionEnd"],
    \   ["onCopy", "onCut", "onPaste"],
    \   ["onDragEnter", "onDragLeave"],
    \   ["onDragStart", "onDragEnd"],
    \   ["onFocus", "onBlur"],
    \   ["onKeyDown", "onKeyUp"],
    \   ["onMouseDown", "onMouseUp"],
    \   ["onMouseEnter", "onMouseLeave"],
    \   ["onTouchStart", "onTouchEnd"],
    \   ["addEventListener", "removeEventListener"],
    \   ["animationstart", "animationend"],
    \   ["change", "input", "submit"],
    \   ["dblclick", "click"],
    \   ["compositionstart", "compositionend"],
    \   ["copy", "cut", "paste"],
    \   ["dragenter", "dragleave"],
    \   ["dragstart", "dragend"],
    \   ["focus", "blur"],
    \   ["keydown", "keyup"],
    \   ["mousedown", "mouseup"],
    \   ["mouseenter", "mouseleave"],
    \   ["touchstart", "touchend"],
    \
    \   ["componentDidMount", "componentDidUpdate", "componentWillUnmount"],
    \   ["useState", "useEffect", "useContext", "useMemo", "useRef", "useReducer", "useCallback"],
    \   ["getState", "setState"],
    \   ["container", "component"],
    \
    \   ["atan", "tan"],
    \   ["ceil", "floor"],
    \   ["cos", "sin"],
    \   ["Math.atan", "Math.tan"],
    \   ["Math.ceil", "Math.floor"],
    \   ["Math.cos", "Math.sin"],
    \   ["Math.min", "Math.max"],
    \   ["min", "max"],
    \
    \   ["deactivate", "activate"],
    \   ["address", "port"],
    \   ["add", "remove"],
    \   ["unavailable", "available"],
    \   ["background", "foreground"],
    \   ["before", "after"],
    \   ["client", "server"],
    \   ["disconnected", "connected"],
    \   ["disconnect", "connect"],
    \   ["development", "production"],
    \   ["dev", "prod"],
    \   ["drag", "drop"],
    \   ["file", "folder"],
    \   ["first", "last"],
    \   ["from", "to"],
    \   ["get", "set"],
    \   ["input", "output"],
    \   ["uninstall", "install"],
    \   ["all", "each", "only"],
    \   ["key", "value"],
    \   ["unload", "load"],
    \   ["minor", "major"],
    \   ["online", "offline"],
    \   ["open", "close"],
    \   ["parent", "child"],
    \   ["positive", "negative"],
    \   ["prefix", "suffix"],
    \   ["previous", "next"],
    \   ["public", "private"],
    \   ["request", "response"],
    \   ["req", "res"],
    \   ["row", "column"],
    \   ["short", "long"],
    \   ["show", "hide"],
    \   ["source", "destination"],
    \   ["start", "stop"],
    \   ["invalid", "valid"],
    \   ["visible", "hidden"],
    \   ["width", "height"],
    \
    \   ["0", "1"],
    \   ["enabled", "disabled"],
    \   ["enable", "disable"],
    \   ["if", "else"],
    \   ["on", "off"],
    \   ["true", "false"],
    \   ["yes", "no"],
    \
    \   ["div", "span"],
    \   ["head", "body"],
    \   ["header", "footer"],
    \   ["ol", "ul"],
    \   ["tr", "td"],
    \
    \   ["in", "out"],
    \   ["up", "down"],
    \ ]

let s:switch_toggler_vscode_defaults_symbols =
    \ [
    \   ["(", ")"],
    \   ["[", "]"],
    \   ["{", "}"],
    \   ["'", "\""],
    \
    \   ["*=", "/="],
    \   ["*", "/"],
    \   ["&&", "||"],
    \   ["&", "|"],
    \   ["++", "--"],
    \   ["+=", "-="],
    \   ["+", "-"],
    \   ["<=", ">="],
    \   ["<", ">"],
    \ ]

let s:switch_words  = map(s:switch_toggler_vscode_defaults_words, 'switch#NormalizedCaseWords(v:val)')

" react: https://github.com/AndrewRadev/switch.vim/wiki/React-props
" markdown: https://github.com/AndrewRadev/switch.vim/wiki/Markdown-checkboxes
let s:switch_definitions =
            \ {
            \   'react' : {
            \       '\(\k\+=\){\([[:keyword:].]\+\)}':      '\1{`${\2}`}',
            \       '\(\k\+=\){`${\([[:keyword:].]\+\)}`}': '\1{\2}',
            \     },
            \   'markdown_ul_checkbox': {
            \       '\v^(\s*[*+-] )?\[ \]': '\1[x]',
            \       '\v^(\s*[*+-] )?\[x\]': '\1[\~]',
            \       '\v^(\s*[*+-] )?\[\~\]': '\1[ ]',
            \     },
            \   'markdown_ol_checkbox': {
            \       '\v^(\s*\d+\. )?\[ \]': '\1[x]',
            \       '\v^(\s*\d+\. )?\[x\]': '\1[\~]',
            \       '\v^(\s*\d+\. )?\[\~\]': '\1[ ]',
            \     },
            \   'equality': {
            \       '!==\(=\)\@!': '===',
            \       '\(=\)\@<!===\(=\)\@!': '!==',
            \       '!=\(=\)\@!': '==',
            \       '\(!\)\@<!==\(=\)\@!': '!=',
            \     },
            \ }

let g:switch_custom_definitions =
            \ [
            \   s:switch_definitions.equality,
            \ ]
call extend(g:switch_custom_definitions, s:switch_words)
call extend(g:switch_custom_definitions, s:switch_toggler_vscode_defaults_symbols)

autocmd FileType vim let b:switch_definitions =
    \ [
    \   g:switch_builtins.vim_script_local_function,
    \ ]

autocmd FileType javascript,typescript let b:switch_definitions =
    \ [
    \   g:switch_builtins.javascript_function,
    \   g:switch_builtins.javascript_arrow_function,
    \   g:switch_builtins.javascript_es6_declarations,
    \   s:switch_definitions.react,
    \ ]

autocmd FileType markdown let b:switch_definitions =
    \ [
    \   s:switch_definitions.markdown_ul_checkbox,
    \   s:switch_definitions.markdown_ol_checkbox,
    \ ]

""" Make it work with the usual increment/decrement functions, including speeddating

" Don't use default mappings
let g:speeddating_no_mappings = 1

" Avoid issues because of us remapping <c-a> and <c-x> below
nnoremap <Plug>SpeedDatingFallbackUp <C-a>
nnoremap <Plug>SpeedDatingFallbackDown <C-x>

" Manually invoke speeddating in case switch didn't work
nnoremap <C-a> :if !switch#Switch() <Bar>
      \ call speeddating#increment(v:count1) <bar> endif<CR>
nnoremap <C-x> :if !switch#Switch({'reverse': 1}) <Bar>
      \ call speeddating#increment(-v:count1) <bar> endif<CR>

