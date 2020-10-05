#!/bin/bash

### Preamble

case "$OSTYPE" in
    darwin*)
        READLINK=/usr/local/bin/greadlink
        if [[ ! -x $READLINK ]]; then
            echo "$0: error: $READLINK could not be found. Run \`brew install coreutils\`" >&2
            exit 1
        fi
        GETOPT=/usr/local/opt/gnu-getopt/bin/getopt
        if [[ ! -x $GETOPT ]]; then
            echo "$0: error: $GETOPT could not be found. Run \`brew install gnu-getopt\`" >&2
            exit 1
        fi
        ;;
    *)
        READLINK=readlink
        GETOPT=getopt
        ;;
esac

SCRIPT="$($READLINK -f "${BASH_SOURCE[0]}")"
SCRIPT_NAME="$(basename "$SCRIPT")"
SCRIPT_DIR="$(dirname "$SCRIPT")"

### Usage

usage()
{
  cat <<END >&2
Usage: $SCRIPT_NAME [-h|--help] [-n|--dry-run] [-a value|--argument value] [file...]
       -h|--help: get help
       -n|--dry-run: don't make any modifications
       -f|--force: overwrite symlinks
END
  exit 1
}

### Option defaults

opt_dry_run=
opt_force=

### Options

opts=$($GETOPT --options hnf --long help,dry-run,force --name "$SCRIPT_NAME" -- "$@")
[ $? != 0 ] && usage
eval set -- "$opts"

while true; do
  case "$1" in
    -h | --help) usage ;;
    -n | --dry-run) opt_dry_run=1; shift ;;
    -f | --force) opt_force=f; shift ;;
    --) shift; break ;;
    *) echo "$SCRIPT_NAME: Internal error!" >&2; exit 1 ;;
  esac
done

[[ $# -gt 0 ]] && usage

### Function

function symlink {
    target="$1"
    link_name="$2"

    if [[ -h "$link_name" ]]; then
        link_target="$(readlink "$link_name")"
        if [[ "$link_target" != "$target" ]]; then
            if [[ -z $opt_force ]]; then
                echo "$SCRIPT_NAME: error: $link_name is pointing to $link_target" >&2
                return 1
            fi
        else
            return 0
        fi
    elif [[ -e "$link_name" ]]; then
        echo "$SCRIPT_NAME: error: $link_name already exists" >&2
        return 1
    fi

    echo ln -s$opt_force "$1" "$2"
    [[ -z $opt_dry_run ]] && ln -s$opt_force "$1" "$2"
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
