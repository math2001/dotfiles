
" let b:functionindentlevel = -1
" setlocal foldmethod=expr
" setlocal foldexpr=FoldFunctions(v:lnum)
" setlocal foldtext=FoldText()
execute 'setlocal fillchars+=fold:\ '
nnoremap <buffer> <leader>b :call BuildPython(0)<CR>
nnoremap <buffer> <leader>b :!python %<CR>
nnoremap <buffer> <leader>r :call BuildPython(1)<CR>
nnoremap <buffer> M :BLines def <CR>
setlocal colorcolumn=81
iabbrev <buffer> yeild yield
" ALEDisable
