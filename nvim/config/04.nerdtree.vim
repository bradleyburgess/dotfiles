" NERDTree settings
" =====================================

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

" KEYBINDINGS
" ====================================
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :NERDTreeFind<CR>
