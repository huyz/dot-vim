#!/bin/sh
# huyz 2011-07-02
# Download & compile packages

alias git='git -c user.name="huyz" -c user.email=h-git@huyz.us'

### Configuration

umask 022
GIT_CLONE_ARGS="--depth 1"

### End of configuration


cd ~/.vim || exit 10

[ -x ~/.vim/bin/vimruntime.sh ] || exit 20
VIMRUNTIME=$(~/.vim/bin/vimruntime.sh)

for i in packages autoload bundle plugin macros syntax; do
  if [ ! -d "$i" ]; then
    mkdir "$i" || exit 30
  fi
done

#############################################################################
### Individually-loaded packages

cd ~/.vim/packages || exit 40

# Clone pathogen
[ -d vim-pathogen ] || git clone $GIT_CLONE_ARGS git://github.com/tpope/vim-pathogen.git
[ -h ../autoload/pathogen.vim ] || ln -s ../packages/vim-pathogen/autoload/pathogen.vim ../autoload/.

# Scripts
[ -e closetag.vim ] || wget -O closetag.vim 'http://www.vim.org/scripts/download_script.php?src_id=4318'
[ -h ../plugin/closetag.vim ] || ln -s ../packages/closetag.vim ../plugin/.
[ -e spamassassin.vim ] || wget -O spamassassin.vim 'http://www.vim.org/scripts/download_script.php?src_id=15948'
[ -h ../syntax/spamassassin.vim ] || ln -s ../packages/spamassassin.vim ../syntax/.
[ -e outline.vim ] || wget -O outline.vim 'http://www.vim.org/scripts/download_script.php?src_id=6852'
[ -h ../syntax/outline.vim ] || ln -s ../packages/outline.vim ../syntax/.

# The latest version updated March 18th, 2003 is not accessible online, so we
# check it in
#[ -e rcs-menu.vim ] || wget -O rcs-menu.vim 'http://www.vim.org/scripts/download_script.php?src_id=59'
#[ -h ../plugin/rcs-menu.vim ] || ln -s ../packages/rcs-menu.vim ../plugin/.

[ -d less.vim ] || git clone $GIT_CLONE_ARGS git@github.com:huyz/less.vim.git
[ -h ../macros/less.vim ] || ln -s ../packages/less.vim/less.vim ../macros/.
[ -h ../bin/m ] || ln -s ../packages/less.vim/m ../bin/.

#############################################################################
### Pathogen-loaded bundles

cd ~/.vim/bundle || exit 50

### vimball

[ -e vimball.tar.gz ] || wget -O vimball.tar.gz 'http://www.vim.org/scripts/download_script.php?src_id=15362'
if [ ! -d vimball ]; then
  mkdir vimball &&
    if cd vimball; then
      tar -xvf ../vimball.tar.gz
      cd ..
    fi
fi

### bufexplorer archive

[ -e bufexplorer.zip ] || wget -O bufexplorer.zip 'http://www.vim.org/scripts/download_script.php?src_id=14208'
if [ ! -d bufexplorer ]; then
  mkdir bufexplorer &&
    if cd bufexplorer; then
      unzip ../bufexplorer.zip
      cd ..
    fi
fi

### EnhancedCommentify archive

[ -e EnhancedCommentify-2.3.tar.gz ] || wget -O EnhancedCommentify-2.3.tar.gz 'http://www.vim.org/scripts/download_script.php?src_id=8319'
if [ ! -d EnhancedCommentify-2.3 ]; then
  tar xzvf EnhancedCommentify-2.3.tar.gz
  # Patch for a few more file types and for key mappings
  patch -p1 --ignore-whitespace <<END
--- a/EnhancedCommentify-2.3/plugin/EnhancedCommentify.vim       2008-02-22 06:37:57.000000000 +1100
+++ b/EnhancedCommentify-2.3/plugin/EnhancedCommentify.vim       2011-07-03 03:18:51.000000000 +1000
@@ -777,10 +777,10 @@
                 \ 'fgl\|fvwm\|gdb\|gnuplot\|gtkrc\|hb\|hog\|ia64\|icon\|'.
                 \ 'inittab\|lftp\|lilo\|lout\|lss\|lynx\|maple\|mush\|'.
                 \ 'muttrc\|nsis\|ora\|pcap\|pine\|po\|procmail\|'.
-                \ 'psf\|ptcap\|r\|radiance\|ratpoison\|readline\remind\|'.
+                \ 'psf\|ptcap\|r\|radiance\|ratpoison\|readline\|remind\|'.
                 \ 'ruby\|screen\|sed\|sm\|snnsnet\|snnspat\|snnsres\|spec\|'.
                 \ 'squid\|terminfo\|tidy\|tli\|tsscl\|vgrindefs\|vrml\|'.
-                \ 'wget\|wml\|xf86conf\|xmath\)$'
+                \ 'wget\|wml\|xf86conf\|xmath\|elinks\|links\|mailcap\|coffee\)$' " huyz 2011-08-07
         let b:ECcommentOpen = '#'
         let b:ECcommentClose = ''
     elseif fileType == 'webmacro'
@@ -1532,6 +1532,11 @@
         "
         " *** Put your personal bindings here! ***
         "
+            " huyz 2011-07-02
+            let s:c = '<Leader>/<space>'
+            let s:x = '<Leader>//'
+            let s:C = '<Leader>/C'
+            let s:X = '<Leader>/u'
     else
         if useAltKeys
             let s:c = '<M-c>'
@@ -1544,6 +1549,8 @@
             let s:C = '<Leader>C'
             let s:X = '<Leader>X'
         endif
+    " huyz 2011-07-02
+    endif
 
         if traditionalMode
             let s:Method = 'Traditional'
@@ -1595,7 +1602,8 @@
             execute 'vmap '. where .' <silent> <unique> '. s:x
                         \ .' <Plug>Visual'. s:Method
         endif
-    endif
+    " huyz 2011-07-02
+    " endif
 endfunction
 
 if !s:ECbindPerBuffer
END
fi

### Clone read-only git repos

[ -d vim-json ] || git clone $GIT_CLONE_ARGS https://github.com/elzr/vim-json.git
[ -d gundo.vim ] || git clone $GIT_CLONE_ARGS https://github.com/sjl/gundo.vim.git
[ -d minibufexpl.vim ] || git clone $GIT_CLONE_ARGS https://github.com/fholgado/minibufexpl.vim.git
[ -d nerdcommenter ] || git clone $GIT_CLONE_ARGS https://github.com/scrooloose/nerdcommenter.git
[ -d nerdtree ] || git clone $GIT_CLONE_ARGS https://github.com/scrooloose/nerdtree.git
[ -d snipmate.vim ] || git clone $GIT_CLONE_ARGS https://github.com/msanders/snipmate.vim.git
[ -d vim-gnupg ] || git clone $GIT_CLONE_ARGS https://github.com/jamessan/vim-gnupg.git
[ -d tagbar ] || git clone $GIT_CLONE_ARGS https://github.com/majutsushi/tagbar.git
[ -d ctrlp.vim ] || git clone $GIT_CLONE_ARGS https://github.com/kien/ctrlp.vim.git
[ -d ~/.fzf ] || git clone $GIT_CLONE_ARGS https://github.com/junegunn/fzf.git ~/.fzf
[ -d vim-indent-guides ] || git clone $GIT_CLONE_ARGS https://github.com/nathanaelkane/vim-indent-guides.git
[ -d vim-less ] || git clone $GIT_CLONE_ARGS https://github.com/groenewege/vim-less.git
[ -d vim-airline ] || git clone $GIT_CLONE_ARGS https://github.com/bling/vim-airline
[ -d vim-gitgutter ] || git clone $GIT_CLONE_ARGS https://github.com/airblade/vim-gitgutter.git
[ -d syntastic ] || git clone $GIT_CLONE_ARGS https://github.com/scrooloose/syntastic.git
[ -d vim-surround ] || git clone $GIT_CLONE_ARGS https://github.com/tpope/vim-surround.git
[ -d vim-easymotion ] || git clone $GIT_CLONE_ARGS https://github.com/easymotion/vim-easymotion.git
[ -d vim-table-mode ] || git clone $GIT_CLONE_ARGS https://github.com/dhruvasagar/vim-table-mode.git
[ -d vim-multiple-cursors ] || git clone $GIT_CLONE_ARGS https://github.com/terryma/vim-multiple-cursors.git

[ -d webapi-vim ] || git clone $GIT_CLONE_ARGS https://github.com/mattn/webapi-vim.git
[ -d gist-vim ] || git clone $GIT_CLONE_ARGS https://github.com/mattn/gist-vim.git

# vim-solarized is contained within the larger repository solarized, so check
# first for the global location
if [ ! -h vim-colors-solarized ]; then
  if [ -d ~/git/solarized ]; then
    ln -s ~/git/solarized/vim-colors-solarized .
  else
    [ -d solarized ] || git clone $GIT_CLONE_ARGS http://github.com/altercation/solarized.git
    ln -s solarized/vim-colors-solarized .
  fi
fi


#############################################################################
### Vimball

### Align

[ -e Align.vba.gz -o -e Align.vba ] || wget -O Align.vba.gz 'http://www.vim.org/scripts/download_script.php?src_id=19633'
if [ ! -d Align ]; then
  # Align generates errors because it expects to close a window
  mkdir Align &&
    vim -e -T dumb -c "let g:vimball_home = '$PWD/Align' | e Align.vba.gz | so % | quit" >/dev/null 2>&1
fi

### AutoAlign

[ -e AutoAlign.vba.gz -o -e AutoAlign.vba ] || wget -O AutoAlign.vba.gz 'http://www.vim.org/scripts/download_script.php?src_id=21105'
if [ ! -d AutoAlign ]; then
  # AutoAlign generates errors because it expects to close a window
  mkdir AutoAlign &&
    vim -e -T dumb -c "let g:vimball_home = '$PWD/AutoAlign' | e AutoAlign.vba.gz | so % | quit" >/dev/null 2>&1
fi

### CamelCaseMotion

[ -e camelcasemotion.vba.gz -o -e camelcasemotion.vba ] || wget -O camelcasemotion.vba.gz 'http://www.vim.org/scripts/download_script.php?src_id=16854'
if [ ! -d camelcasemotion ]; then
  # camelcasemotion generates errors because it expects to close a window
  mkdir camelcasemotion &&
    vim -e -T dumb -c "let g:vimball_home = '$PWD/camelcasemotion' | e camelcasemotion.vba.gz | so % | quit" >/dev/null 2>&1
fi

### ingo-library (required by CompleteHelper)

[ -e ingo-library.vmb.gz -o -e ingo-library.vmb ] || wget -O ingo-library.vmb.gz 'http://www.vim.org/scripts/download_script.php?src_id=22895'
if [ ! -d ingo-library ]; then
  # ingo-library generates errors because it expects to close a window
  mkdir ingo-library &&
    vim -e -T dumb -c "let g:vimball_home = '$PWD/ingo-library' | e ingo-library.vmb.gz | so % | quit" >/dev/null 2>&1
fi

### CompleteHelper (required by CamelCaseComplete)

[ -e CompleteHelper.vmb.gz -o -e CompleteHelper.vmb ] || wget -O CompleteHelper.vmb.gz 'http://www.vim.org/scripts/download_script.php?src_id=22724'
if [ ! -d CompleteHelper ]; then
  # CompleteHelper generates errors because it expects to close a window
  mkdir CompleteHelper &&
    vim -e -T dumb -c "let g:vimball_home = '$PWD/CompleteHelper' | e CompleteHelper.vmb.gz | so % | quit" >/dev/null 2>&1
fi

### CamelCaseComplete

[ -e CamelCaseComplete.vmb.gz -o -e CamelCaseComplete.vmb ] || wget -O CamelCaseComplete.vmb.gz 'http://www.vim.org/scripts/download_script.php?src_id=21213'
if [ ! -d CamelCaseComplete ]; then
  # CamelCaseComplete generates errors because it expects to close a window
  mkdir CamelCaseComplete &&
    vim -e -T dumb -c "let g:vimball_home = '$PWD/CamelCaseComplete' | e CamelCaseComplete.vmb.gz | so % | quit" >/dev/null 2>&1
fi

#############################################################################
### Generate helptags for docs

vim -e -T dumb -c "call pathogen#helptags() | quit"

exit 0
