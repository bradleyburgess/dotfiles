" Lilypond Syntax highlighting
filetype off
set runtimepath+=/usr/local/share/lilypond/current/vim/
filetype on
syntax on

" Set comment string
au BufNewFile,BufRead,BufEnter *.ly setlocal commentstring=%\ %s
