#!/bin/sh
# huyz 2011-07-03
# Sets up everything.
# TODO: this is mainly for me, not user-friendly for general use.

if [ ! -e setup.sh -o ! -e .vimrc ]; then
  echo "ERROR: This script needs to be run from within the git repository" >&2
  exit 1
fi

GIT=$PWD

cd ~
[ -h ~/.vim ] || ln -s $GIT .vim
[ -h ~/.vimrc ] || ln -s $GIT/.vimrc .
[ -h ~/.exrc ] || ln -s $GIT/.exrc .

[ -d ~/bin ] || mkdir ~/bin
[ -d ~/bin -a -h ~/bin/m ] || ln -s $GIT/bin/m ~/bin/.

cd $GIT

./get-packages.sh

# This is only for me
if [ -e .vimrc.post.gpg -a ! -e .vimrc.post ]; then
  if command -v gpg >/dev/null 2>&1; then 
    gpg -d -o .vimrc.post .vimrc.post.gpg && touch -r .vimrc.post.gpg .vimrc.post
  else
    echo "Warning: gpg not found.  Cannot decrypt .vimrc.post.gpg" >&2
  fi
fi
