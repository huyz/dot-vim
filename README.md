# Files

| File          | Description                                                                                                        |
| ------------- | ------------------------------------------------------------------------------------------------------------------ |
| `.exrc`       | basic initialization file for the original ex/vi, in case vim isn't installed. It has to be symlinked to `~/.exrc` |
| `.vimrc`      | main initialization file. It has to be symlinked to `~/.vimrc`                                                     |
| `.vimrc.post` | contains personal commands invoked after `.vimrc`. You can create this file with your own customizations here.     |
| `setup.sh`    | sets up the files to be ready for vim.                                                                             |

# Installation

Requires:

- curl
- gpg [just for my private .vimrc.post.gpg]

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

| Mapping                                              | Description                                                                                                                                        |
| ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cgn` + `.`                                          | Incrementally change matches                                                                                                                       |
| `q:` `q/` `q?`                                       | Open comand-line window (`^F` if already in command-line)                                                                                          |
| `` \`. ``                                            | Jump to last modification                                                                                                                          |
| `gv`                                                 | Reselect last visual selection                                                                                                                     |
| `ga`                                                 | ASCII/Unicode value of current character                                                                                                           |
| `gP` then `.`…                                       | Paste successively                                                                                                                                 |
| `viw` `cis` `dap` `yab` `ci'` `cit` `dat` `` ci`  `` | Operations on word, inner sentence, paragraph, () block, quoted strings, html tags                                                                 |
| `/<C-R><C-W>`                                        | Pull current word into search                                                                                                                      |
| `/<C-R>"`                                            | Pull in last yank                                                                                                                                  |
| `[I`                                                 | Show lines that match current word                                                                                                                 |
| `` `[ `` or `` `]``                                  | Go to beginning/end of last change                                                                                                                 |
| `<C-X><C-L>`                                         | Starts line completion                                                                                                                             |
| `<C-X><C-K>`                                         | Starts dictionary completion                                                                                                                       |
| `==`                                                 | Reindent line(s)                                                                                                                                   |
| `:ce`                                                | Center line(s)                                                                                                                                     |
| `!!date`                                             | Replace current line with date (different from my `\-d`)                                                                                           |
| `:-1r`                                               | Read in file above current line                                                                                                                    |
| `:argdo %s/f//`                                      | Operate over all files listed on command line                                                                                                      |
| `:windo %s/f//`                                      | Operate over all viewable split windows                                                                                                            |
| `:bufdo normal :%s,^,^R%,^M`                         | perform an operation on all buffers when a register needs to be accessed (note that ^R ^M are typed by hitting control-v and then control-r or -m) |
| `:bufdo exe "normal :%s,^,\<C-R>%,\<CR>"`            | same as above                                                                                                                                      |
| `:verbose set history?`                              | Find where an option is set                                                                                                                        |
| `:w !sudo tee %`                                     | Save the current file with sudo privileges                                                                                                         |

## My own mappings

I tend to forgot I defined these mappings:

| Mapping                  | Description                                                                     |
| ------------------------ | ------------------------------------------------------------------------------- |
| `<C-s>`                  | Save buffer                                                                     |
| `<C-q><C-s>`             | Save buffer and reload configs                                                  |
| `<C-q><C-r>`             | Reload configs                                                                  |
| `ZA`                     | Exit vim but prompt for unsaved buffers                                         |
| `ZM`                     | Save even if nomodifiable (and preserve nomodifiable, thus overriding modeline) |
| `gb`                     | Re-select last pasted block                                                     |
| `Q` `gq` `<M-q>`         | In visual mode, format by `par`, vim                                            |
| `<M-f><C-S-BS>`          | Discard consecutive blank lines                                                 |
| `<M-x>#-` or `#=` or`#~` | Underline line                                                                  |
| `<D-M-S-->` `<D-M-S-+>`  | Increment/decrement (all-mode alternative to `<C-a>` and `<C-x>`)               |
| i\_`<C-s>`               | Swap last two characters (my own function)                                      |

## Plugins I installed

### windowswap

| Mapping | Description                        |
| ------- | ---------------------------------- |
| `\ww`   | Set first or second window to swap |

### Bbye

| Mapping      | Description                                  |
| ------------ | -------------------------------------------- |
| `<C-q><C-w>` | Close buffer without messing up split window |

### visual-multi

| Mapping            | Description                                                    |
| ------------------ | -------------------------------------------------------------- |
| `<C-n>` or `n`     | Select word at cursor, or next occurrence of current selection |
| `<C-S-n>` or `N`   | Select previous occurrence of current selection                |
| `<M-q>` or `q`     | Skip current occurrence                                        |
| `<M-S-Q>` or `Q`   | Unselect occurrence                                            |
| `<M-S-G>` or `\\A` | Select all occurrences                                         |
| `<M-S-/>` or `\\/` | Select by regex                                                |
| `<C-Down>`         | Add cursor(s) vertically                                       |
| `\\S` or `\\gS`    | Reselect last                                                  |

### easymotion

| Mapping | Description                                       |
| ------- | ------------------------------------------------- |
| `-abc`  | Highlight n-character matches                     |
| `_`     | Go to previous n-character match                  |
| `+`     | Go to next n-character match                      |
| `\\w`   | Highlight consecutive targets of word motion      |
| `\\t`   | Highlight consecutive targets of character motion |

### CamelCaseMotion

| Mapping                 | Description                                               |
| ----------------------- | --------------------------------------------------------- |
| `,w` `,b` `,e`          | like regular motions but respecting word boundaries       |
| `ci,w` `di,w`           | like regular change/delete but respecting word boundaries |
| `c2i,b` `y2i,b` `v2i,b` | change/yank/select the current word and previous word     |

### surround

| Mapping   | Description                                                        |
| --------- | ------------------------------------------------------------------ |
| `ysiw'`   | surround inner word with single quotes                             |
| `yss)`    | surround sentence with parentheses and no space                    |
| `ys2w(`   | surround next 2 words with parentheses and spaces                  |
| `ySS{`    | surround sentence with braces on their own lines                   |
| v\_`S{`   | in line visual mode, surround lines with braces on their own lines |
| v\_`gS\|` | in block visual mode, surround each line with bars, with alignment |
| `dst`     | delete surrounding tags                                            |
| `cs't`    | change surrounding quotes to tag with prompt                       |
| `csw(`    | shortcut for `ysiw(`                                               |

My more concise shortcuts:

| Mapping  | Description                                      |
| -------- | ------------------------------------------------ |
| ``ys` `` | surround inner word with backticks               |
| `yS*`    | surround outer word with `**` markdown bold `**` |
| v\_`sw`  | surround with `[[` wikilink `]]`                 |

### vim-switch

| Mapping | Description                                |
| ------- | ------------------------------------------ |
| `<C-z>` | Toggle value (to match `<C-a>` and `<C-x>` |

### vim-move

| Mapping    | Description                           |
| ---------- | ------------------------------------- |
| `<M-Up>`   | Move current character/selection up   |
| `<M-Left>` | Move current character/selection left |

### easy-align

| Mapping   | Description                                                    |
| --------- | -------------------------------------------------------------- |
| V\_`gA= ` | in line visual mode, start aligning around first `=` character |
| `gAip=`   | start aligning for inner paragraph                             |
| V\_`\\`   | In Github-Flavored Markdown file, re-align current table       |

### ReplaceWithRegister

| Mapping      | Description                         |
| ------------ | ----------------------------------- |
| `gr{motion}` | Replace {motion} text with register |
| `grr`        | Replace line(s) with register       |

### abolish

| Mapping    | Description                 |
| ---------- | --------------------------- |
| `:Subvert` | case-preserving subsitution |

### eregex

| Mapping  | Description        |
| -------- | ------------------ |
| `:S`     | PCRE2 substitution |
| `<M-s>/` | Toggle PCRE search |

### exchange

| Mapping Description |                                            |
| ------------------- | ------------------------------------------ |
| `cx{motion}`        | Sets first or second text to swap/exchange |
| `cxx`               | Sets first or second line to swap/exchange |
| `cxx`               | Sets first or second line to swap/exchange |
| `<M-x><M-x>`        | Swap last two words (my own function)      |

### argumentative

| Mapping       | Description                   |
| ------------- | ----------------------------- |
| `⇧⌥.` or `<.` | Shift function argument right |

### targets

| Mapping | Description              |
| ------- | ------------------------ |
| `cia`   | Change function argument |
| `daa`   | Delete function argument |

### indent-object (useful for Python)

| Mapping | Description                                                        |
| ------- | ------------------------------------------------------------------ |
| `vai`   | Select indentation level + line above                              |
| `vii`   | Select indentation level                                           |
| `vaI`   | Select idnentation level + line below (useful for closing bracket) |

### table-mode

| Mapping  | Description       |
| -------- | ----------------- |
| `<M-m>f` | Reformat table    |
| `<M-m>t` | Toggle table mode |
| `<M-m>i` | Insert column     |
| `<M-m>a` | Append column     |
| `<M-m>x` | Delete column     |
| `<M-m>d` | Delete row        |

### splitjoin

| Mapping | Description                            |
| ------- | -------------------------------------- |
| `gS`    | Trigger smart split wherever cursor is |
| `gJ`    | Trigger smart join wherever cursor is  |

### gitmoji

| Mapping  | Description                              |
| -------- | ---------------------------------------- |
| `<M-c>:` | Trigger completion                       |
| `\\^U`   | Convert :emoji_name: into unicode emojis |
