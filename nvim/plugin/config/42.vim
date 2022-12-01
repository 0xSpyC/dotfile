"42 vimrc
filetype off
filetype plugin indent on
set smartindent
set tabstop=4
set shiftwidth=4
set noexpandtab
set nocompatible
set modelines=1
set hidden
set ttyfast
set backspace=indent,eol,start
set laststatus=2
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

syntax on
set encoding=utf-8
set nu
set rnu
set background=dark
set nowrap

colorscheme ayu

let g:user42 = 'rtazlaou'
let g:mail42 = 'rtazlaou@student.42mulhouse.fr'

:nmap L <Cmd>tabnext<CR>
:nmap H <Cmd>tabprevious<CR>


source ~/.config/nvim/plugin/config/c_formatter_42.vim
