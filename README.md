huy'z ~/.vim\* files
====================

These are my `~/.vim*` files with customizations, integrating many of the tips
n' tricks from the net.
Customizing vim is essential because new releases try too hard to maintain
backward compatibility.

Suggestions are appreciated.

Features:

*   Supports vim 7.x
*   Sane set of options.
*   Supports function and control keys of popular terminals.
*   Functions to cycle through different textwidths, virtual-edit modes,
    visual editing aids, methods of displaying/handling long lines.
*   Installs nice plugins, sometimes with patches
    *   [pathogen](http://www.vim.org/scripts/script.php?script_id=2332) -
        autoloads plugins from their own individual directories under
        `bundle/`
    *   [yankring](http://www.vim.org/scripts/script.php?script_id=1234) -
        allows you to paste then ctrl-P through a history of yanks
    *   [bufexplorer](http://www.vim.org/scripts/script.php?script_id=42) -
        buffer explorer/browser
    *   [MiniBufExplorer](http://fholgado.com/minibufexpl) - shows small
        buffer explorer at all times
    *   [CtrlP](https://github.com/kien/ctrlp.vim/) - fuzzy file finder
    *   [snipmate](http://www.vim.org/scripts/script.php?script_id=2540) - TextMate-style snippets
    *   [closetag](http://www.vim.org/scripts/script.php?script_id=13)
        \- functions and mappings to close open HTML/XML tags
    *   [NERDCommenter](http://www.vim.org/scripts/script.php?script_id=1218)
        \- code commenting for many file types
    *   [EnhancedCommentify](http://www.vim.org/scripts/script.php?script_id=23)
        \- code commenting (alternative style)
    *   [Align](http://www.vim.org/scripts/script.php?script_id=294) - Helps
        align text, equations, tables, etc.
    *   [AutoAlign](http://www.vim.org/scripts/script.php?script_id=884) -
	automatically aligns as you type in certain languages, e.g. C, C++, HTML,
	vim.
    *   [vim-table-mode](https://github.com/dhruvasagar/vim-table-mode) -
        instant table creation
    *   [Gist.vim](http://www.vim.org/scripts/script.php?script_id=2423) -
        post buffers or selected text to https://gist.github.com/
    *   [vim-gnupg](https://github.com/jamessan/vim-gnupg) - transparent editing of GPG-encrypted files
    *   [vim-jsbeautify](https://github.com/maksimr/vim-jsbeautify) - format
        JS, HTML, CSS files with js-beautify
    *   [rcs-menu](http://lanzarotta.tripod.com/vim.html) - interface to RCS version control system
    *   [vim-json](https://github.com/elzr/vim-json) - better JSON for Vim
    *   [gundo](http://sjl.bitbucket.org/gundo.vim/) - visualize undo tree
        [requires vim to be compiled with Python 2.4+]
    *   [less.vim](https://github.com/huyz/less.vim) - my improved version of
        less.{vim,sh} distributed with vim for paging through files/stdin with
        full syntax highlighting
    *   [vim-coffee-script](https://github.com/kchmck/vim-coffee-script) -
        CoffeeScript support
    *   [vimball](http://www.vim.org/scripts/script.php?script_id=1502) -
        weird vim-based archiver that is required to install some a few
        plugins, mainly Align and AutoAlign.  Largely deprecated by pathogen.
    *   [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides)
        - visually displaying indent levels in code
    *   [vim-over](https://github.com/osyo-manga/vim-over)
        - Preview substitution
    *   [vim-surround](https://github.com/tpope/vim-surround.git)
        - Quick commands for inserting, deleting, changing quotes and the like
    *   [camelcasemotion](http://www.vim.org/scripts/script.php?script_id=1905)
        - provides motions through camel-case and underscore-notated words
    *   [CamelCaseComplete](http://www.vim.org/scripts/script.php?script_id=3915)
        - completes identifiers by just typing initials of camel-case or
          underscore-delimited keywords
*   Installs the color scheme:
    *   [Solarized](http://ethanschoonover.com/solarized/vim-colors-solarized)
*   Installs the syntax highlighting scripts for:
    *   [jade](http://www.vim.org/scripts/script.php?script_id=3192)
    *   [golang](https://github.com/jnwhiteh/vim-golang)
    *   [lesscss](http://leafo.net/lessphp/vim/less.vim)
    *   [outline](http://www.vim.org/scripts/script.php?script_id=1266) - to use fold-mode with emacs org-mode files.
    *   [spamassassin](http://www.vim.org/scripts/script.php?script_id=2617&rating=helpful)
    *   [stylus](http://www.vim.org/scripts/script.php?script_id=3513)

Files
-----

*   `.exrc` - basic initialization file for the original ex/vi, in case vim isn't
    installed.  It has to be symlinked to `~/.exrc`
*   `.vimrc` - main initialization file.  It has to be symlinked to `~/.vimrc`
*   `.vimrc.post` - contains personal commands invoked after `.vimrc`.  You
    can create this file with your own customizations here.
*   `setup.sh` - sets up the files to be ready for vim.
*   `get-packages.sh` - downloads and installs needed vim packages.

Vim Quick-Reference
-------------------

### General tips ###

These are useful commands that are easy to forget because they're needed only
occasionally.

*   `q:`  `q/`  `q?`    :   Open comand-line window (`^F` if already in command-line)
*   ``\`.``             :   Jump to last modification
*   `gv`                :   Reselect last visual selection
*   `ga`                :   ASCII/Unicode value of current character
*   `viw` `cis` `dap` `yab` `ci'` `ci"` ``ci` ``
    : Operations on word, inner sentence, paragraph, () block, quoted strings
*   `/<C-R><C-W>`       :   Pull current word into search
*   `/<C-R>"`           :   Pull in last yank
*   `[I`                :   Show lines that match current word
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

### My own mappings ###

I tend to forgot I defined these mappings:

*   `Q`              : Right after yanking a block, paste and move cursor to end
*   `gb`             : Re-select last pasted block
*   `<C-k>` `<C-j>`  : Quick switch between split windows
*   `<C-w><C-q>`     : Closes buffer without messing up split window
*   `\lh`            : Swap words
*   `\t0`            : Discard consecutive blank lines
*   `Q` `gq` `<M-q>` : In visual mode, format by `par`, vim, or emacs-style
*   `<Meta>q`        : Reformat paragraph (like emacs)
*   `:S` instead `:s` : For perl-compatible regexp
*   `<C-s>`          : Save buffer

### Plugins I installed ###

bufexplorer     :   Easily select open buffers

*   `\be`       :   launch
*   `\bs`       :   split and launch

closetag        :   Closes HTML/XML tabs

*   `<C-_>`     :   close nearest open tag

NERD commenter  :   Comments/Decomments based on file type

*   `\c/`       :   Comment line(s) with alignment
*   `\cu`       :   Decomment line(s)
*   `\c<Space>` :   Toggles commenting of current line and goes to next line

EnhancedCommentify : Comments/Decomments based on file type

*   `\//`          :   Comment line(s) (Unlike NERD, puts comment in column 1)
*   `\/u`          :   Decomment line(s)
*   `\/<space>`    :   Toggles commenting of current line and goes to next line

Align           : Aligns text into columns around delimiters

*   `\t=`       : Align line or selection around '=' signs
*   `:Align :`  : Align line around ':' (or arbitrary characters)
*   `\tsp`      : Align line or selection around whitespace, i.e. align "words"
*   `\acom`	: Align comments
*   `\Htd`	: Align HTML tables

table-mode            :   Table editing

*   `\tm`             :   Toggle table mode

Gist                 : post buffers or selected text to https://gist.github.com/

*   `:Gist`          : post entire buffer
*   `:Gist -p`  : post entire buffer to a private gist
*   ``:`<,`>Gist -a``  : post selected text anonymously
*   `:Gist -e`       : edit gist

Gundo           : Shows undo tree

*   `:GundoToggle`

vim-jsbeautify

*   `\B`            : beautify JS, HTML, or CSS, depending on filetype

vimspell        :   Spell checks (live for certain files) [deprecated]

*   `\ss`       : write file, spellcheck file & highlight spelling mistakes.
*   `\sA`       : start autospell mode.
*   `\sq`       : return to normal syntax coloring and disable auto spell checking.
*   `\sl`       : switch between languages.
*   `\sn`       : go to next error.
*   `\sp`       : go to previous error.
*   `\si`       : insert word under cursor into directory.
*   `\su`       : insert word under cursor as lowercase into directory.
*   `\sa`       : accept word for this session only.
*   `\s?`       : check for alternatives.

CtrlP

*   `F11`       : quickly switch buffer
*   `F12`       : quickly switch file

yankring

*   `\cN`       : (After pasting) rotate through other items in the clipboard
*   `\cP`       : (After pasting) rotate backward

vim-surround

*   `ysiw'`     : surround inner word with single quotes
*   `yss)`      : surround sentence with parentheses and no space
*   `ys2w(`     : surround next 2 words with parentheses and spaces
*   `ySS{`      : surround sentence with braces on their own lines
*   v\_`S{`     : in line visual mode, surround lines with braces on their own lines
*   v\_`gS|`    : in block visual mode, surround each line with bars, with
                  alignment
*   `dst`       : delete surrounding tags
*   `cs't`      : change surrounding quotes to tag with prompt
*   `csw(`      : shortcut for `ysiw(`b

camelcasemotion

*   `,w` `,b` `,e`  : like regular motions but respecting word boundaries
*   `ci,w` `di,w`   : like regular change/delete but respecting word boundaries
*   `c2i,b` `y2i,b` `v2i,b` : change/yank/select the current word and previous word

CamelCaseComplete

*   `Ccc<C-X><C-C>` : completes on camel-case or underscore-delimited words
    (note that case of first letter matters)

Installation
------------

Requires:

* curl
* gpg [only for me, huyz]

```
[ -d ~/git ] || mkdir ~/git
git clone https://github.com/huyz/dot-vim.git
[ -d ~/.vim ] && mv ~/.vim ~/.vim-OLD
ln -s ~/git/dot-vim ~/.vim
cd ~/.vim
./setup.sh
```

Comments
--------
You can submit feedback on [GitHub](https://github.com/huyz/dot-vim/issues)
or [my blog](http://huyz.us/).

MIT License
-----------

Non-stolen parts are  Copyright (C) 2011 Huy Z

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
