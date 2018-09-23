set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dracula/vim'

call vundle#end()
filetype plugin indent on

colorscheme dracula
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1

set noswapfile

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

syntax enable
