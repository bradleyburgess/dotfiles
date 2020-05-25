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

" Keybinding: Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
