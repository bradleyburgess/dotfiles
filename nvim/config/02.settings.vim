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
set textwidth=80    " Default to textwidth of 80

" ===================================================================
" COLORS
" ===================================================================
" Terminal color fallback
if (has("termguicolors"))
  set termguicolors
endif
colorscheme gruvbox
set background=dark

" From Primeagen
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" ===================================================================
" LANGUAGE: JAVASCRIPT / TYPESCRIPT
" ===================================================================
" When entering JS files, rescan buffers for syntax
au BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
au BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Read typescript files
au BufNewFile,BufRead,BufEnter *.ts setlocal filetype=typescript
au BufNewFile,BufRead,BufEnter *.ts setlocal indentexpr=GetTypescriptIndent()
au BufNewFile,BufRead,BufEnter *.tsx setlocal filetype=typescriptreact

" Read all JS as JSX
" augroup filetype_jsx
"     autocmd!
"     autocmd FileType javascript set filetype=javascriptreact
" augroup END

" ===================================================================
" LANGUAGE: JSON
" ===================================================================
set conceallevel=0
let g:vim_json_syntax_conceal = 0           " Disable JSON conceal
" Read JSON as JSONC
au BufNewFile,BufRead,BufEnter tsconfig.* setlocal ft=jsonc
au BufNewFile,BufRead,BufEnter tsconfig.* setlocal commentstring=//\ %s

" ===================================================================
" LANGUAGE: MARKDOWN
" ===================================================================
let g:vim_markdown_conceal = 0              " Disable markdown conceal
let g:vim_markdown_conceal_code_blocks = 0  "
let g:vim_markdown_conceal_links = 0        "
let g:vim_markdown_folding_level = 2        " Fold to heading level 2

" ===================================================================
" KEY BINDINGS
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

" Center next search results
nnoremap n nzz
nnoremap N Nzz

" Center { and } paragraph navigation
nnoremap { {zz
nnoremap } }zz

" Navigating table columns
nnoremap <leader>cn f\|2l<S-R>
nnoremap <leader>cp <S-F>\|;2l<S-R>
nnoremap <leader>tn f\|2l
nnoremap <leader>tp <S-F>\|;2l

" Clear search highlight (:noh)
nnoremap <silent> <C-L> :noh<CR>

" Ctrl-/ to comment / uncomment
nnoremap <C-/> :Commentary<CR>
vnoremap <C-/> :Commentary<CR>
