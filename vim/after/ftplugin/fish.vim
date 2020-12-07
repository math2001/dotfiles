packadd ale

function! BuildFish()
    execute "!fish ".bufname('%')
endfunction

nnoremap <leader>b :call BuildFish()<CR>
" ALEDisable

set formatoptions-=ron1
syntax on
