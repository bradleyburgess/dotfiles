call plug#begin("~/.vim/plugged")
    Plug 'dracula/vim', { 'as': 'dracula' }          " Dracula theme
    " Plug 'tomasiser/vim-code-dark'                   " VS Code dark theme
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Coc
    " Plug 'Yggdroot/indentLine'                       " Indent lines
    " Plug 'kien/ctrlp.vim'                            " Ctrl-P (like VS Code)
    Plug '~/.vim/plugged/code-dark_bb'
    Plug 'itchyny/lightline.vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
            \'coc-emmet', 
            \'coc-css', 
            \'coc-html', 
            \'coc-json', 
            \'coc-prettier', 
            \]
call plug#end()
