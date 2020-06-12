" ===================================================================
" GENERAL
" ===================================================================
"set mouse=a		" Enable mouse usage (all modes)
filetype plugin indent on 
set autowrite		" Automatically save before commands like :next and :make
set cursorline      " Highlight current line
set cursorcolumn    " Highlight current column
set encoding=utf-8  " UTF-8 encoding
set hidden		    " Hide buffers when they are abandoned
set nocompatible	" Enable ViM features
set norelativenumber	" Relative line numbers
set number          " Absolute line numbers
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set splitbelow    " spawn horizontal splits below instead of above"
set splitright    " spawn vertical splits to the right instead of left"
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
colorscheme codedark

" ===================================================================
" KEYBINDINGS
" ===================================================================
" inoremap jk <ESC>
nnoremap <silent> <S-PageUp> :-tabmove<CR>
nnoremap <silent> <S-PageDown> :+tabmove<CR>

" ===================================================================
" MISCELLANEOUS
" ===================================================================
" Fix indentLine JSON quotes
let g:vim_json_conceal=0
