" ===================================================================
" GENERAL
" ===================================================================
filetype plugin indent on 
set autowrite		           " Auto save before commands like :next and :make
set encoding=utf-8         " UTF-8 encoding
set hidden		             " Hide buffers when they are abandoned
set nobackup               " No backup
set nocompatible	         " Enable ViM features
set noerrorbells           " No sounds
set undodir=~/.vim/undodir " Undo Directory
set undofile
syntax on

" ===================================================================
" INTERFACE (highlights, splits, numbers, etc.)
" ===================================================================
set colorcolumn=80         " Highlight 80th column
set cursorcolumn           " Highlight current column
set cursorline             " Highlight current line
set norelativenumber	     " No Relative line numbers
set nowrap                 " No wrap by default
set number                 " Absolute line numbers
set showcmd		             " Show (partial) command in status line.
set showmatch		           " Show matching brackets.
set splitbelow             " spawn horizontal splits below instead of above
set splitright             " spawn vertical splits to the right instead of left

" ===================================================================
" SEARCH
" ===================================================================
set hlsearch		  " Highligh search results
set ignorecase		" Do case insensitive matching
set incsearch		  " Incremental search
set smartcase		  " Do smart case matching

" ===================================================================
" SPACES & TABS
" ===================================================================
set autoindent
set copyindent      " copy indent from the previous line
set expandtab       " tabs are space
set shiftwidth=2    " number of spaces to use for autoindent
set softtabstop=2   " number of spaces in tab when editing
set tabstop=2       " number of visual spaces per TAB

" ===================================================================
" COLORS
" ===================================================================
" Terminal color fallback
if (has("termguicolors"))
  set termguicolors
endif
colorscheme gruvbox

" ===================================================================
" MISCELLANEOUS
" ===================================================================
let g:vim_json_conceal=0          " Fix indentLine JSON quotes

" ===================================================================
" KEYBINDINGS
" ===================================================================
" Leader key
let mapleader = " "

" Move tabs
nnoremap <silent> <S-PageUp> :-tabmove<CR>
nnoremap <silent> <S-PageDown> :+tabmove<CR>

" Navigating splits using ViM movements
nnoremap <silent> <leader>h <C-W><C-H>
nnoremap <silent> <leader>j <C-W><C-J>
nnoremap <silent> <leader>k <C-W><C-K>
nnoremap <silent> <leader>l <C-W><C-L>

" Quick insert blank line witout leaving normal mode
nnoremap <Leader>o o<Esc>0D
nnoremap <Leader>O O<Esc>0D

" Clear search highlight (:noh)
nnoremap <silent> <C-L> :noh<CR>

" Ctrl-/ to comment / uncomment
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>
