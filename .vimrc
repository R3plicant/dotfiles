set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'

call vundle#end()
filetype plugin indent on

colo gruvbox
set background=dark

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

syntax enable
