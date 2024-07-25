" FUZZY FINDER CONFIG
" ========================================

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
