" VIM PLUGINS
" ============================================      ================================

call plug#begin("~/.vim/plugged")
  " UNUSED
  " Plug 'dracula/vim', { 'as': 'dracula' }             " Dracula theme
  " Plug 'kien/ctrlp.vim'                               " Ctrl-P (like VS Code)
  " Plug 'tomasiser/vim-code-dark'                      " VS Code dark theme
  " Plug 'tpope/vim-sensible'                           " Sensible defaults
  
  " GENERAL
  Plug 'airblade/vim-rooter'                            " Project-based search
  Plug 'mbbill/undotree'                                " Undo tree
  Plug 'vim-utils/vim-man'                              " Vim manpage
  Plug 'wlemuel/vim-tldr'                               " TLDR for Vim

  " THEMES / UI
  Plug '~/.vim/plugged/code-dark_bb'                    " Forked VS Code theme
  Plug 'Yggdroot/indentLine'                            " Indent lines
  Plug 'itchyny/lightline.vim'                          " Lightline bar
  Plug 'morhetz/gruvbox'                                " Gruvbox
  Plug 'shinchu/lightline-gruvbox.vim'                  " Lightline gruvbox

  " LANGUAGE PACKS
  Plug 'cakebaker/scss-syntax.vim'                      " Sass
  Plug 'evidens/vim-twig'                               " Twig language
  Plug 'sheerun/vim-polyglot'                           " Language packs

  " AUTOCOMPLETE ETC
  Plug 'jiangmiao/auto-pairs'                           " Auto pairs
  Plug 'neoclide/coc.nvim', {'branch': 'release'}       " COC
  Plug 'tpope/vim-commentary'                           " Comments
  Plug 'tpope/vim-repeat'                               " Extended repeat func
  Plug 'tpope/vim-surround'                             " Surround

  " FILE MANAGEMENT
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   " Fuzzy Finder
  Plug 'junegunn/fzf.vim'                               " FZF
  Plug 'preservim/nerdtree'                             " NERDtree
  Plug 'ryanoasis/vim-devicons'                         " NERD icons

  " COC EXTENSIONS:
  " let g:coc_global_extensions = [
  "       \'coc-emmet', 
  "       \'coc-eslint',
  "       \'coc-css', 
  "       \'coc-html', 
  "       \'coc-json', 
  "       \'coc-prettier', 
  "       \'coc-python',
  "       \'coc-tsserver',
  "       \'coc-yaml',
  "       \'coc-yank',
  "       \]
call plug#end()
