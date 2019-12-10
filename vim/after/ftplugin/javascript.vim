packadd vim-javascript
packadd ale

nnoremap <buffer> <leader>b :call Build('node')<cr>
iabbrev <buffer> len length
setlocal tabstop=2 shiftwidth=2

" reload the syntax
syntax off
syntax on
