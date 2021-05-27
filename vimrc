" This must be first, because it changes other options as side effect
set encoding=utf-8
set nocompatible
set nowrap        " don't wrap lines
set autoindent    "
set expandtab     "
set tabstop=4     " a tab is four spaces
"set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
syntax on         " Enables vim's syntax highlighting
set ruler         " Show the current row and column
set nobackup
set noswapfile

colors desert

" make backspace work like most other apps
set backspace=indent,eol,start  " more powerful backspacing

" Start vim in insert mode
" au BufRead,BufNewFile * start

" enable filetype detection:
filetype on
filetype plugin on
filetype indent on " file type based indentation

autocmd FileType make setlocal noexpandtab
