filetype on
filetype plugin on
filetype indent on
set autoindent

syntax on

set foldmethod=indent
set foldlevel=1

set scrolloff=10
set smartcase

set expandtab
set tabstop=4
set shiftwidth=4

set number
set relativenumber

set wildmenu
" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set showmode

