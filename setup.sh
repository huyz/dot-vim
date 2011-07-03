#!/bin/sh
# huyz 2011-07-03
# Sets up everything.
# TODO: this is mainly for me, not user-friendly for general use.

if [ ! -e setup.sh -o ! -e .vimrc ]; then
  echo "ERROR: This script needs to be run from within the git repository" >&2
  exit 1
fi

GIT=$PWD

cd ~ || exit 1
[ -h ~/.vimrc ] || ln -s $GIT/.vimrc .
[ -h ~/.exrc ] || ln -s $GIT/.exrc .

[ -d ~/bin -a -h ~/bin/m ] || ln -s $GIT/bin/m ~/bin/.

cd $GIT

./get-packages.sh

# This is only for me
[ -e .vimrc.post ] || gpg -d -o .vimrc.post .vimrc.post.gpg && touch -r .vimrc.post.gpg .vimrc.post
