" ===================================================================
" VIM-PLUG
" ===================================================================

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===================================================================
" VIM PLUGINS
" ===================================================================

call plug#begin("~/.vim/plugged")
  " UNUSED
  
  " GENERAL
  Plug 'ctrlpvim/ctrlp.vim'                               " Ctrl-P (like VS Code)
  Plug 'tpope/vim-sensible'                           " Sensible defaults
  Plug 'airblade/vim-rooter'                            " Project-based search
  Plug 'mbbill/undotree'                                " Undo tree

  " THEMES / UI
  Plug 'Yggdroot/indentLine'                            " Indent lines
  Plug 'itchyny/lightline.vim'                          " Lightline bar
  Plug 'gruvbox-community/gruvbox'                      " Gruvbox (community)
  Plug 'shinchu/lightline-gruvbox.vim'                  " Lightline gruvbox

  " LANGUAGE PACKS
  Plug 'sheerun/vim-polyglot'                         " Language packs
  Plug 'sersorrel/vim-lilypond'
  Plug 'plasticboy/vim-markdown'
  Plug 'elzr/vim-json'
  Plug 'kevinoid/vim-jsonc'
  Plug 'cakebaker/scss-syntax.vim'                      " Sass
  Plug 'jparise/vim-graphql'
  Plug 'pangloss/vim-javascript'
  Plug 'ianks/vim-tsx'
  Plug 'leafgarland/typescript-vim'
  Plug 'arzg/vim-sh'

  " AUTOCOMPLETE ETC
  Plug 'jiangmiao/auto-pairs'                           " Auto pairs
  Plug 'tpope/vim-commentary'                           " Comments
  Plug 'tpope/vim-repeat'                               " Extended repeat func
  Plug 'tpope/vim-surround'                             " Surround
  Plug 'godlygeek/tabular'                              " Alignment

  " FILE MANAGEMENT
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   " Fuzzy Finder
  Plug 'junegunn/fzf.vim'                               " FZF
  Plug 'preservim/nerdtree'                             " NERDtree
  Plug 'ryanoasis/vim-devicons'                         " NERD icons
call plug#end()

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
let g:vim_markdown_folding_level = 0        " Fold to heading level 0
" let g:vim_markdown_folding_level = 2        " Fold to heading level 2

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
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>
" leader-/ for ttys
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" ===================================================================
" NERDTree settings
" ===================================================================

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && 
      \ exists("b:NERDTree") && 
      \ b:NERDTree.isTabTree()) 
      \ | q | endif

" Autostart NERDTree if no file specified, or if opening dir
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" ===================================================================
" KEYBINDINGS
" ===================================================================
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :NERDTreeFind<CR>


" ===================================================================
" FUZZY FINDER CONFIG
" ===================================================================

" KEYBINDNGS
nnoremap <C-p> :FZF<CR>                   
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
" Ripgrep
nnoremap <leader>rg :Rg<CR>

" SETTINGS
let $FZF_DEFAULT_COMMAND = 'ag -g ""'                            " Ignore node
let g:fzf_layout = { 'window': { 'height': 0.8, 'width': 0.8 } } " Window mode
let $FZF_DEFAULT_OPTS = '--reverse'

" ===================================================================
" LIGHTLINE
" ===================================================================
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'component_function': {
      \   'filename': 'FilenameForLightline'
      \ }
      \ }

" Show containing directory and filename
function! FilenameForLightline()
  return expand('%:p:h:t') . " / " . expand('%:t')
endfunction

" OTHER OPTIONS FOR FILENAME:
" return expand('%:p:h:t') . " / " . expand('%:t')
" return expand('%:t') . " (in " . expand('%:p:h:t') . ")"
" return expand('%:p')

