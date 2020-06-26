let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'component_function': {
      \   'filename': 'FilenameForLightline'
      \ }
      \ }

" Show containing directory and filename
function! FilenameForLightline()
  return expand('%:p:h:t') . " / " . expand('%:t')
endfunction

" OTHER OPTIONS FOR FILENAME:
" return expand('%:p:h:t') . " / " . expand('%:t')
" return expand('%:t') . " (in " . expand('%:p:h:t') . ")"
" return expand('%:p')
