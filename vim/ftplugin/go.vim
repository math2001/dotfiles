packadd ale

nnoremap <buffer> M :call FzfJumpDef('go')<CR>
nnoremap <buffer> K :GoDoc<CR>
set nospell
if expand('%:t') == 'scratchpad.go'
    nnoremap <buffer> <leader>b :GoRun<CR>
else
    setlocal makeprg=make
endif

setlocal formatoptions-=a

abbrev <buffer> wr w http.ResponseWriter, r *http.Request

