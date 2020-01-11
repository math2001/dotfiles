nnoremap <buffer> M :Ag ^func <CR>

set nospell

if expand('%:t') == 'scratchpad.go'
    nnoremap <buffer> <leader>b :!env GO111MODULE=off go run %<CR>
else
    setlocal makeprg=make
endif

setlocal formatoptions-=a
setlocal nowrap

abbrev <buffer> wr w http.ResponseWriter, r *http.Request

if expand("%") =~ "_test.go"
    nnoremap <buffer> <leader>b :make! test<cr>
endif

setlocal autoread

augroup buflocalgo
    au!
    au BufWritePost <buffer> silent! make! format | silent redraw!
augroup END

" function! s:minimum_char(options, matches) abort
"     echom a:options
"     echom a:matches

"     let l:visited = {}
"     let l:items = []
"     for [l:source_name, l:matches] in items(a:matches)
"         for l:item in l:matches['items']
"             if stridx(l:item['word'], a:options['base']) == 0
"                 if !has_key(l:visited, l:item['word'])
"                     call add(l:items, l:item)
"                     let l:visited[l:item['word']] = 1
"                 endif
"             endif
"         endfor
"     endfor

"     echom l:items
"     call asyncomplete#preprocess_complete(a:options, l:items)
" endfunction

" let b:asyncomplete_preprocessor = [function('s:minimum_char')]
