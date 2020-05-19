unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Vundle - VIM plugin manager config
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" All Plugins must be added before the following line
call vundle#end()

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

filetype plugin indent on

set nobackup			" do not keep a backup file, user versions instead

set ts=2
set sw=2
set expandtab
set nu
set hlsearch
colorscheme desert

if &diff 
	colorscheme industry
endif

