#!/bin/bash

### Preamble

case "$OSTYPE" in
    darwin*)
        READLINK=/usr/local/bin/greadlink
        if [[ ! -x $READLINK ]]; then
            echo "$0: error: $READLINK could not be found. Run \`brew install coreutils\`" >&2
            exit 1
        fi
        ;;
    *)
        READLINK=readlink
        ;;
esac

SCRIPT="$($READLINK -f "${BASH_SOURCE[0]}")"
SCRIPT_NAME="$(basename "$SCRIPT")"
SCRIPT_DIR="$(dirname "$SCRIPT")"

### Function

function symlink {
    target="$1"
    link_name="$2"

    if [[ -h "$link_name" ]]; then
        link_target="$(readlink "$link_name")"
        if [[ "$link_target" != "$target" ]]; then
            echo "error: $link_name is pointing to $link_target" >&2
        fi
    elif [[ -e "$link_name" ]]; then
        echo "error: $link_name already exists" >&2
    else
        echo ln -s "$1" "$2"
        ln -s "$1" "$2"
    fi
}

### Entire subdir

relative_dir="${SCRIPT_DIR#$HOME/}"

symlink "$relative_dir" ~/.vim

### Contents of base

cd ~
for i in .vimrc .gvimrc .exrc .editorconfig; do
    target=".vim/$i"
    link_name="$(basename "$target")"
    symlink "$target" "$link_name"
done

### Decrypt

cd "$SCRIPT_DIR"

# This is only for me
if [[ -e .vimrc.post.gpg && ! -e .vimrc.post ]]; then
    if command -v gpg &>/dev/null; then 
        gpg -d -o .vimrc.post .vimrc.post.gpg && touch -r .vimrc.post.gpg .vimrc.post
    else
        echo "Warning: gpg not found. Cannot decrypt .vimrc.post.gpg" >&2
    fi
fi
