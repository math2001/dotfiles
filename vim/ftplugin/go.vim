packadd ale

nnoremap <buffer> M :call FzfJumpDef('go')<CR>
nnoremap <buffer> K :GoDoc<CR>
set nospell
if expand('%:t') == 'scratchpad.go'
    nnoremap <buffer> <leader>b :!env GO111MODULE=off go run %<CR>
else
    setlocal makeprg=make
endif

setlocal formatoptions-=a
setlocal nowrap

abbrev <buffer> wr w http.ResponseWriter, r *http.Request

let b:ale_sign_column_always = 1

if expand("%") =~ "_test.go"
	nnoremap <buffer> <leader>b :make! test<cr>
endif
