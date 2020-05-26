" COC SETTINGS
" =================================================


" FUNCTIONS
" =================================================
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" VS Code-like behavior for <CR> with indentation
function! Expander()
  let line   = getline(".")
  let col    = col(".")
  let first  = line[col-2]
  let second = line[col-1]
  let third  = line[col]
  if first ==# ">"
    if second ==# "<" && third ==# "/"
      return "\<CR>\<C-o>==\<C-o>O"
    else
      return "\<CR>"
    endif
  else
    return "\<CR>"
  endif
endfunction

" Create :Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" BINDINGS
" =================================================

" <Tab> for completion selection
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Shift-tab to select previous
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <C-Space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion, OR Expand 
inoremap <expr> <CR> 
      \ pumvisible() ? coc#_select_confirm() : 
      \ Expander() 
      " \<C-g>u\<CR>"
      " "\ pumvisible() ? "\<C-y>" : 

" Prettier
nmap <leader>p :Prettier<CR>
vmap <leader>p  <Plug>(coc-format-selected)
