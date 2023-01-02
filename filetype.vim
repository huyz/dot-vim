" filetype.vim
" CREATED: huyz 2001-07-13

augroup filetype
  " Strip my filename extensions before figuring out the filetype
  au BufNewFile,BufRead
      \ *.ORIG,*.BAK,*.OLD,*.NEW,*.dist,*.DIST,*.dis,*.DIS,*.off,*OFF
      \ exe "doau filetypedetect BufRead " . expand("<afile>:r")

  " General (I didn't come up with these filenames)
  au BufNewFile,BufRead .acrorc         setf xdefaults
  au BufNewFile,BufRead .perldb         setf perl
  au BufNewFile,BufRead .vip,.viper     setf lisp
  au BufNewFile,BufRead /*/Mail/DRAFTS/* setf mail|setlocal tw=0
  au BufNewFile,BufRead /*/News/Score   setf slrnsc
  au BufNewFile,BufRead /*/jboss/conf/*/*.conf setf xml
  au BufNewFile,BufRead *.jade          setf jade
  au BufNewFile,BufRead coc-settings.json set filetype=jsonc
  au BufNewFile,BufRead *.less          setf lesscss
  au BufNewFile,BufRead *.mrc           setf mhonarc
  au BufNewFile,BufRead *.moin          setf moin
  au BufNewFile,BufRead *.wiki          setf moin
  " Approximate since actionscript not available
  au BufNewFile,BufRead *.as            setf javascript
  au BufNewFile,BufRead mail-cap        setf mailcap
  au BufNewFile,BufRead /*/.spamassassin/user_prefs,/*/spamassassin/*.cf,/*/spamassassin/*.pre setf spamassassin

  " My files (I came up with these filenames)
  au BufNewFile,BufRead /*/.ssh/config.local setf sshconfig
  au BufNewFile,BufRead procmailrc*     setf procmail
  au BufNewFile,BufRead tfrc*           setf tf
  au BufNewFile,BufRead screenrc*       setf screen
  au BufNewFile,BufRead .screenrc*      setf screen
  au BufNewFile,BufRead /*/.zfunc/*     setf zsh
  au BufNewFile,BufRead /*/.zshenv.cache/* setf zsh
  au BufNewFile,BufRead .mailcap.*      setf mailcap
  au BufNewFile,BufRead pinerc.*        setf pine
  " This invented filetype works with vimspell and our ftplugin which sets
  " the keywordprog
  au BufNewFile,BufRead *.txt           setf text

augroup END
