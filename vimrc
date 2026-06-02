" Combined .vimrc configuration
" Basic settings must come first as they may affect other options
set encoding=utf-8
set nocompatible

" Enable true colors support
" Dentro de screen NO activamos termguicolors: screen tiene bugs conocidos
" con true-color + BCE que distorsionan los backgrounds. La paleta 256 de
" onedark se ve igual y es estable.
if (has("termguicolors")) && &term !~# '^screen' && &term !~# '^tmux'
    set termguicolors
endif

" Disable Background Color Erase: en 256-color dentro de screen/tmux, BCE
" genera parches al scrollear. Inofensivo afuera. Defensivo.
if &term =~# '256color' || &term =~# '^screen' || &term =~# '^tmux'
    set t_ut=
endif

" Core editor behavior
set nowrap        " don't wrap lines
set autoindent    " automatic indentation
set expandtab     " use spaces instead of tabs
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " show matching parentheses
set ignorecase    " ignore case
set smartcase     " ignore case if search pattern is all lowercase
set smarttab      " insert tabs according to shiftwidth
set ruler         " show current row and column
set backspace=indent,eol,start  " more powerful backspacing
set nobackup      " no backup files
set noswapfile    " no swap files
set nocursorline  " disable cursor line
set background=dark
set signcolumn=yes

" Mas calidad de vida
set hidden          " cambiar de buffer sin guardar
set incsearch       " búsqueda incremental
set wildmenu
set wildmode=longest:full,full
set laststatus=2    " airline siempre visible (en Vim 8 default es 1)
set scrolloff=3
set updatetime=300  " gitgutter reacciona rápido; el default de 4000ms es lentísimo
set noshowmode

" Vim-Plug initialization
call plug#begin('~/.vim/plugged')
" Git integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" UI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Navigation and utility
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gcmt/taboo.vim'
Plug 'tpope/vim-eunuch'
Plug 'easymotion/vim-easymotion'
" Markdown
Plug 'preservim/vim-markdown'
" Color scheme support
Plug 'joshdick/onedark.vim'
" Elixir
Plug 'elixir-editors/vim-elixir'
call plug#end()

" Markdown friendly
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_frontmatter = 1   " resalta frontmatter YAML, útil en prompts/notas

" Para repos grandes
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" SQL
let g:sql_type_default = 'mysql'   " o 'pgsql'

" Fix POSIX/bash = bash friendly
let g:is_posix = 1

" Enable syntax highlighting and filetype detection
syntax on
filetype plugin indent on

augroup vimrc_ft
  autocmd!
  autocmd FileType markdown,text setlocal wrap linebreak breakindent
  autocmd BufRead,BufNewFile *.prompt setlocal filetype=markdown
  autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab indentkeys-=0#
  autocmd FileType elixir,eelixir setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
  autocmd FileType crontab setlocal backupcopy=yes nowritebackup
  autocmd FileType make setlocal noexpandtab
augroup END

" Force pure black background after colorscheme
augroup MyOnedarkFix
  autocmd!
  autocmd ColorScheme onedark
        \  hi Normal       guibg=#000000 ctermbg=NONE
        \| hi SignColumn   guibg=#000000 ctermbg=NONE
        \| hi VertSplit    guibg=#000000 ctermbg=NONE
augroup END
colorscheme onedark

" Language-specific settings
autocmd FileType make setlocal noexpandtab

