" VIM PLUGINS
" ============================================      ================================

call plug#begin("~/.vim/plugged")
  " UNUSED
  " Plug 'sheerun/vim-polyglot'                         " Language packs
  " Plug 'dracula/vim', { 'as': 'dracula' }             " Dracula theme
  " Plug 'kien/ctrlp.vim'                               " Ctrl-P (like VS Code)
  " Plug 'tomasiser/vim-code-dark'                      " VS Code dark theme
  " Plug 'tpope/vim-sensible'                           " Sensible defaults
  " Plug '~/.vim/plugged/code-dark_bb'                  " Forked VS Code theme
  " Plug 'honza/vim-snippets'                           " Snippets
  " Plug 'herringtondarkholme/yats.vim'
  
  " GENERAL
  Plug 'airblade/vim-rooter'                            " Project-based search
  Plug 'mbbill/undotree'                                " Undo tree
  Plug 'vim-utils/vim-man'                              " Vim manpage
  Plug 'wlemuel/vim-tldr'                               " TLDR for Vim
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

  " THEMES / UI
  Plug 'Yggdroot/indentLine'                            " Indent lines
  Plug 'itchyny/lightline.vim'                          " Lightline bar
  Plug 'gruvbox-community/gruvbox'                      " Gruvbox (community)
  Plug 'shinchu/lightline-gruvbox.vim'                  " Lightline gruvbox
  Plug 'jbgutierrez/vim-better-comments'                " Comment highlighting

  " LANGUAGE PACKS
  Plug 'sersorrel/vim-lilypond'
  Plug 'plasticboy/vim-markdown'
  Plug 'elzr/vim-json'
  Plug 'kevinoid/vim-jsonc'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'cakebaker/scss-syntax.vim'                      " Sass
  Plug 'jparise/vim-graphql'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'pangloss/vim-javascript'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'ianks/vim-tsx'
  Plug 'leafgarland/typescript-vim'
  Plug 'jparise/vim-graphql'
  Plug 'arzg/vim-sh'

  " AUTOCOMPLETE ETC
  Plug 'jiangmiao/auto-pairs'                           " Auto pairs
  Plug 'neoclide/coc.nvim', {'branch': 'release'}       " COC
  Plug 'tpope/vim-commentary'                           " Comments
  Plug 'tpope/vim-repeat'                               " Extended repeat func
  Plug 'tpope/vim-surround'                             " Surround
  Plug 'godlygeek/tabular'                              " Alignment

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
