#!/bin/sh
# huyz 2011-07-02
# Download & compile packages

### Configuration

umask 022

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
[ -d vim-pathogen ] || git clone git://github.com/tpope/vim-pathogen.git
[ -h ../autoload/pathogen.vim ] || ln -s ../packages/vim-pathogen/autoload/pathogen.vim ../autoload/.

# Scripts
[ -e closetag.vim ] || wget -O closetag.vim 'http://www.vim.org/scripts/download_script.php?src_id=4318'
[ -h ../plugin/closetag.vim ] || ln -s ../packages/closetag.vim ../plugin/.
[ -e gist.vim ] || wget -O gist.vim 'http://www.vim.org/scripts/download_script.php?src_id=15897'
[ -h ../plugin/gist.vim ] || ln -s ../packages/gist.vim ../plugin/.
[ -e spamassassin.vim ] || wget -O spamassassin.vim 'http://www.vim.org/scripts/download_script.php?src_id=15948'
[ -h ../syntax/spamassassin.vim ] || ln -s ../packages/spamassassin.vim ../syntax/.
[ -e outline.vim ] || wget -O outline.vim 'http://www.vim.org/scripts/download_script.php?src_id=6852'
[ -h ../syntax/outline.vim ] || ln -s ../packages/outline.vim ../syntax/.
[ -e json.vim ] || wget -O json.vim 'http://www.vim.org/scripts/download_script.php?src_id=10853'
[ -h ../syntax/json.vim ] || ln -s ../packages/json.vim ../syntax/.

# The latest version updated March 18th, 2003 is not accessible online, so we
# check it in
#[ -e rcs-menu.vim ] || wget -O rcs-menu.vim 'http://www.vim.org/scripts/download_script.php?src_id=59'
#[ -h ../plugin/rcs-menu.vim ] || ln -s ../packages/rcs-menu.vim ../plugin/.

[ -d less.vim ] || git clone git@github.com:huyz/less.vim.git
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
+                \ 'wget\|wml\|xf86conf\|xmath\|elinks\|links\|mailcap\)$' " huyz 2011-07-03
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

### table archive

[ -e table.zip ] || wget -O table.zip 'http://www.vim.org/scripts/download_script.php?src_id=2322'
[ ! -d table/plugin ] && mkdir -p table/plugin
if [ ! -e table/plugin/table.vim ]; then
  if cd table/plugin; then
    unzip ../../table.zip table.vim
    perl -pi.DIST -e 's/\r$//' table.vim
    # Patch for useful messages
    patch -p1 <<END
--- a/table.vim    2003-11-10 12:12:15.000000000 -0800
+++ b/table.vim    2003-11-10 14:45:51.000000000 -0800
@@ -31,6 +31,8 @@
     let s:heading = TrimWS(ExpandTabs(getline(".")))
 
     if !ValidHeading(s:heading)
+        " huyz 2003-11-10
+        echoerr 'Tablemode: invalid heading'
         return 
     endif
 
@@ -65,6 +67,8 @@
 func! TableToggle()
 
     if !ValidHeading(s:heading)
+        " huyz 2003-11-10
+        echoerr 'Tablemode: invalid heading.  Did you select one yet?'
         return 
     endif
 
@@ -89,6 +93,8 @@
     inoremap <silent> <Tab>    <C-O>:call NextField(1)<CR>
     nnoremap <silent> <S-Tab>  :call PrevField()<CR>
     inoremap <silent> <S-Tab>  <C-O>:call PrevField()<CR>
+    " huyz 2003-11-10
+    echo 'Tablemode: enabled'
 endfunc
 
 " Function: Disable Maps
@@ -101,6 +107,8 @@
     iunmap <Tab>
     nunmap <S-Tab>
     iunmap <S-Tab>
+    " huyz 2003-11-10
+    echo 'Tablemode: disabled'
 endfunc
END
    cd ../..
  fi
fi
if [ ! -d table/doc ]; then
  mkdir -p table/doc &&
    if cd table/doc; then
      unzip ../../table.zip table.txt
      cd ../..
    fi
fi

### Clone read-only git repos

[ -d gundo.vim ] || git clone http://github.com/sjl/gundo.vim.git
[ -d minibufexpl.vim ] || git clone http://github.com/fholgado/minibufexpl.vim.git
[ -d nerdcommenter ] || git clone http://github.com/scrooloose/nerdcommenter.git
[ -d snipmate.vim ] || git clone http://github.com/msanders/snipmate.vim.git
[ -d vim-gnupg ] || git clone git://gitorious.org/vim-gnupg/vim-gnupg.git

# vim-solarized is contained within the larger repository solarized, so check
# first for the global location
if [ ! -h vim-colors-solarized ]; then
  if [ -d ~/git/solarized ]; then
    ln -s ~/git/solarized/vim-colors-solarized .
  else
    [ -d solarized ] || git clone http://github.com/altercation/solarized.git
    ln -s solarized/vim-colors-solarized .
  fi
fi


#############################################################################
### Vimball

### Align

[ -e Align.vba.gz -o -e Align.vba ] || wget -O Align.vba.gz 'http://www.vim.org/scripts/download_script.php?src_id=10110'
if [ ! -d Align ]; then
  # Align generates errors because it expects to close a window
  mkdir Align &&
    vim -e -T dumb -c "let g:vimball_home = '$PWD/Align' | e Align.vba.gz | so % | quit" >&/dev/null
fi

### AutoAlign

[ -e AutoAlign.vba.gz -o -e AutoAlign.vba ] || wget -O AutoAlign.vba.gz 'http://www.vim.org/scripts/download_script.php?src_id=7510'
if [ ! -d AutoAlign ]; then
  # AutoAlign generates errors because it expects to close a window
  mkdir AutoAlign &&
    vim -e -T dumb -c "let g:vimball_home = '$PWD/AutoAlign' | e AutoAlign.vba.gz | so % | quit" >&/dev/null
fi

#############################################################################
### Generate helptags for docs

vim -e -T dumb -c "call pathogen#helptags() | quit"
