call plug#begin("~/.vim/plugged")
  " Plug 'Yggdroot/indentLine'                         " Indent lines
  " Plug 'dracula/vim', { 'as': 'dracula' }            " Dracula theme
  " Plug 'kien/ctrlp.vim'                              " Ctrl-P (like VS Code)
  " Plug 'tomasiser/vim-code-dark'                     " VS Code dark theme
  Plug 'itchyny/lightline.vim'                         " Lightline bar
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy Finder
  Plug 'neoclide/coc.nvim', {'branch': 'release'}      " COC Completion
  Plug 'sheerun/vim-polyglot'                          " Language packs
  Plug 'tpope/vim-commentary'                          " Comments
  Plug 'tpope/vim-repeat'                              " Extended repeat func
  Plug 'tpope/vim-sensible'                            " Sensible defaults
  Plug 'tpope/vim-surround'                            " Surround
  Plug '~/.vim/plugged/code-dark_bb'                   " Forked VS Code theme
  Plug 'preservim/nerdtree'                            " NERDtree
  Plug 'cakebaker/scss-syntax.vim'                     " Sass
  Plug 'jiangmiao/auto-pairs'                          " Auto pairs
  Plug 'evidens/vim-twig'                              " Twig language
  Plug 'ryanoasis/vim-devicons'                        " NERD icons
  Plug 'wlemuel/vim-tldr'

  " Coc extensions:
  let g:coc_global_extensions = [
        \'coc-emmet', 
        \'coc-eslint',
        \'coc-css', 
        \'coc-html', 
        \'coc-json', 
        \'coc-prettier', 
        \'coc-python',
        \'coc-tsserver',
        \'coc-yaml',
        \'coc-yank',
        \]
call plug#end()
