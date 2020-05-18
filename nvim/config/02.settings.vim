" ===================================================================
" GENERAL
" ===================================================================
"set mouse=a		" Enable mouse usage (all modes)
filetype plugin indent on 
set nocompatible	" Enable ViM features
set encoding=utf-8  " UTF-8 encoding
set autowrite		" Automatically save before commands like :next and :make
set hidden		    " Hide buffers when they are abandoned
set number          " Absolute line numbers
set relativenumber	" Relative line numbers
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
syntax on

" ===================================================================
" SEARCH
" ===================================================================
set hlsearch		" Highligh search results
set ignorecase		" Do case insensitive matching
set incsearch		" Incremental search
set smartcase		" Do smart case matching

" ===================================================================
" SPACES & TABS
" ===================================================================
set autoindent
set copyindent      " copy indent from the previous line
set expandtab       " tabs are space
set shiftwidth=4    " number of spaces to use for autoindent
set softtabstop=4   " number of spaces in tab when editing
set tabstop=4       " number of visual spaces per TAB

" ===================================================================
" COLORS
" ===================================================================
" Terminal color fallback
if (has("termguicolors"))
	set termguicolors
endif
colorscheme codedark

" ===================================================================
" KEYBINDINGS
" ===================================================================
 inoremap jk <ESC>

" ===================================================================
" MISCELLANEOUS
" ===================================================================
" Fix indentLine JSON quotes
let g:vim_json_conceal=0
