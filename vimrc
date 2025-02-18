" Combined .vimrc configuration
" Basic settings must come first as they may affect other options
set encoding=utf-8
set nocompatible

" Enable true colors support
if (has("termguicolors"))
    set termguicolors
endif

" Core editor behavior
set nowrap        " don't wrap lines
set autoindent    " automatic indentation
set expandtab     " use spaces instead of tabs
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " show matching parentheses
set smartcase     " ignore case if search pattern is all lowercase
set smarttab      " insert tabs according to shiftwidth
set ruler         " show current row and column
set backspace=indent,eol,start  " more powerful backspacing
set nobackup      " no backup files
set noswapfile    " no swap files
set nocursorline  " disable cursor line
set background=dark

" Vim-Plug initialization
call plug#begin('~/.vim/plugged')
" Git integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" UI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
" Navigation and utility
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gcmt/taboo.vim'
Plug 'tpope/vim-eunuch'
Plug 'easymotion/vim-easymotion'
" Language support
Plug 'plasticboy/vim-markdown'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'LnL7/vim-nix'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'pearofducks/ansible-vim'
" Color scheme support
Plug 'vim-scripts/AfterColors.vim'
Plug 'joshdick/onedark.vim'
call plug#end()

" Enable syntax highlighting and filetype detection
syntax on
filetype on
filetype plugin on
filetype indent on

" Apply One Dark with customizations
colorscheme onedark

" Force pure black background after colorscheme
autocmd VimEnter * hi Normal guibg=#000000 ctermbg=0
autocmd VimEnter * hi LineNr guibg=#000000 ctermbg=0
autocmd VimEnter * hi SignColumn guibg=#000000 ctermbg=0
autocmd VimEnter * hi VertSplit guibg=#000000 ctermbg=0
autocmd VimEnter * hi CursorLine guibg=#000000 ctermbg=0
autocmd VimEnter * hi CursorLineNr guibg=#000000 ctermbg=0

" Language-specific settings
autocmd FileType make setlocal noexpandtab
" autocmd BufRead,BufNewFile *.zig set filetype=zig

