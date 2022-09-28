# Files

| File          | Description                                                                                                         |
| ---           | ---                                                                                                                 |
| `.exrc`       | basic initialization file for the original ex/vi, in case vim isn't installed.  It has to be symlinked to `~/.exrc` |
| `.vimrc`      | main initialization file.  It has to be symlinked to `~/.vimrc`
| `.vimrc.post` | contains personal commands invoked after `.vimrc`.  You can create this file with your own customizations here.     |
| `setup.sh`    | sets up the files to be ready for vim.                                                                              |

# Installation

Requires:

* curl
* gpg [just for my private .vimrc.post.gpg]

```
[ -d ~/.vim ] && mv ~/.vim ~/.vim-OLD
git clone https://github.com/huyz/dot-vim.git .vim
cd ~/.vim
./setup.sh
```

# Mapping Quick Reference

## General tips

These are useful commands that are easy to forget because they're needed only
occasionally.

*   `cgn` + `.`         :   Incrementally change matches
*   `q:`  `q/`  `q?`    :   Open comand-line window (`^F` if already in command-line)
*   ``\`.``             :   Jump to last modification
*   `gv`                :   Reselect last visual selection
*   `ga`                :   ASCII/Unicode value of current character
*   `gP` then `.`…      :   Paste successively
*   `viw` `cis` `dap` `yab` `ci'` `cit` `dat` ``ci` ``
    : Operations on word, inner sentence, paragraph, () block, quoted strings,
      html tags
*   `/<C-R><C-W>`       :   Pull current word into search
*   `/<C-R>"`           :   Pull in last yank
*   `[I`                :   Show lines that match current word
*   ```[ `` or `` `]``  :   Go to beginning/end of last change
*   `<C-X><C-L>`        :   Line complete, then hit `<C-n>` and `<C-p>`
*   `<C-X><C-K>`        :   Starts dictionary completion, then hit `<C-n>` and `<C-p>`
*   `==`                :   Reindent line(s)
*   `:ce`               :   Center line(s)
*   `!!date`            :   Replace current line with date (different from my `\-d`)
*   `:-1r`              :   Read in file above current line
*   `:reg`              :   List registers
*   `:argdo %s/f//`     :   Operate over all files listed on command line
*   `:windo %s/f//`     :   Operate over all viewable split windows
*   `:bufdo normal :%s,^,^R%,^M` : perform an operation on all buffers when
                      a register needs to be accessed (note that ^R ^M are
                      typed by hitting control-v and then control-r or -m)
*   `:bufdo exe "normal :%s,^,\<C-R>%,\<CR>"` : same as above
*   `:verbose set history?` : Find where an option is set
*   `:w !sudo tee %`    :   Save the current file with sudo privileges
*   `:perldo s/p/r/`    :   Do perl-compatible regex substitution

## My own mappings

I tend to forgot I defined these mappings:

*   `<C-s>`          : Save buffer
*   `<A-H>` `<A-J>`  : switch between split windows (note capitalization so there's no conflict with vim-visual-multi)
*   `<C-w><C-q>`     : Closes buffer without messing up split window
*   `gb`             : Re-select last pasted block
*   `\lh`            : Swap words
*   `Q` `gq` `<M-q>` : In visual mode, format by `par`, vim, or emacs-style
*   `\t0`            : Discard consecutive blank lines
*   `<Meta>q`        : Reformat paragraph (like emacs)

## Plugins I installed

### Gundo           : Shows undo tree

*   `:GundoToggle`

### CtrlP

*   `<C-P>`     : switch buffer
*   `<C-P><C-B>` : find file
*   `<C-P><C-F>` : find MRU file
*   `F10`       : switch buffer

### fzf

*   `F11`       : find file

### vim-visual-multi

| Mapping                 | Description                                                    |
|-------------------------|----------------------------------------------------------------|
| `<C-n>`                 | Select word at cursor, or next occurrence of current selection |
| `N`                     | Select previous occurrence of current selection                |
| `Q`                     | Unselect occurrence                                            |
| `q`                     | Skip current occurrence                                        |
| `\A`                    | Select all occurrences                                         |
| `<C-down>` then `<Tab>` | Add cursor(s) vertically                                       |

### vim-easymotion

| Mapping | Description                                       |
| ---     | ---                                               |
| `-abc`  | Highlight n-character matches                     |
| `_`     | Go to previous n-character match                  |
| `+`     | Go to nextncharacter match                        |
| `\\w`   | Highlight consecutive targets of word motion      |
| `\\t`   | Highlight consecutive targets of character motion |

### CamelCaseMotion

*   `,w` `,b` `,e`  : like regular motions but respecting word boundaries
*   `ci,w` `di,w`   : like regular change/delete but respecting word boundaries
*   `c2i,b` `y2i,b` `v2i,b` : change/yank/select the current word and previous word

### vim-surround

| Mapping   | Description                                                        |
| --------- | --------------------                                               |
| `ysiw'`   | surround inner word with single quotes                             |
| `yss)`    | surround sentence with parentheses and no space                    |
| `ys2w(`   | surround next 2 words with parentheses and spaces                  |
| `ySS{`    | surround sentence with braces on their own lines                   |
| v\_`S{`   | in line visual mode, surround lines with braces on their own lines |
| v\_`gS\|` | in block visual mode, surround each line with bars, with alignment |
| `dst`     | delete surrounding tags                                            |
| `cs't`    | change surrounding quotes to tag with prompt                       |
| `csw(`    | shortcut for `ysiw(`                                               |

### vim-easy-align

| Mapping    | Description                                                    |
| ---------- | ---------------------                                          |
| V\_`gA= `  | in line visual mode, start aligning around first `=` character |
| `gAip=`    | start aligning for inner paragraph                             |
| V\_`\\`    | In Github-Flavored Markdown file, re-align current table       |

### table-mode

*   `\tm`             =   Toggle table mode

### ReplaceWithRegister

| Mapping | Description                      |
| ---     | ---                              |
| `gr{motion}` | Replace {motion} text with register |
| `grr`   | Replace line(s) with register |

### vim-titlecase

| Mapping    | Description           |
| ---------- | --------------------- |
| gz         | title-case            |
| gzz        | title-case line       |

### vim-gitmoji

| Mapping    | Description           |
| ---------- | --------------------- |
| `^X^U`     | Trigger completion    |

### vim-exchange

| Mapping      | Description                                |
| ---          | ---                                        |
| `cx{motion}` | Sets first or second text to swap/exchange |
| `cxx`        | Sets first or second line to swap/exchange |

### targets

| Mapping | Description              |
| ----    | ---                      |
| `cia`   | Change function argument |
| `daa`   | Delete function argument |

### vim-indent-object (useful for Python)

| Mapping | Description                                                        |
| ---     | ---                                                                |
| `vai`   | Select indentation level + line above                              |
| `vii`   | Select indentation level                                           |
| `vaI`   | Select idnentation level + line below (useful for closing bracket) |
### emmet-vim

| Mapping  | Description         |
|----------|---------------------|
| `<C-Y>,` | Expand abbreviation |

### Gist                 : post buffers or selected text to https://gist.github.com/

*   `:Gist`          : post entire buffer
*   `:Gist -p`  : post entire buffer to a private gist
*   ``:`<,`>Gist -a``  : post selected text anonymously
*   `:Gist -e`       : edit gist
