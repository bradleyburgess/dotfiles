call plug#begin("~/.vim/plugged")
  " Plug 'Yggdroot/indentLine'                       " Indent lines
  " Plug 'dracula/vim', { 'as': 'dracula' }          " Dracula theme
  " Plug 'kien/ctrlp.vim'                            " Ctrl-P (like VS Code)
  " Plug 'tomasiser/vim-code-dark'                   " VS Code dark theme
  Plug 'itchyny/lightline.vim'                       " Lightline bar
  Plug 'junegunn/fzf.vim'                            " Fuzzy Finder
  Plug 'neoclide/coc.nvim', {'branch': 'release'}    " COC Completion
  Plug 'sheerun/vim-polyglot'                        " Language packs
  Plug 'tpope/vim-commentary'                        " Add comments
  Plug 'tpope/vim-repeat'                            " Extended repeat func
  Plug 'tpope/vim-sensible'                          " Sensible defaults
  Plug 'tpope/vim-surround'                          " Surround
  Plug '~/.vim/plugged/code-dark_bb'                 " Forked VS Code theme
  " Coc extensions:
  let g:coc_global_extensions = [
        \'coc-emmet', 
        \'coc-css', 
        \'coc-html', 
        \'coc-json', 
        \'coc-prettier', 
        \]
call plug#end()
