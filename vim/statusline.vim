" makes the status line
set statusline=

set statusline+=%{&readonly?'R':''}
set statusline+=%{&modifiable==0?'F':''}
set statusline+=%{&modified?'*':''}

set statusline+=%y
if &ff !=# 'unix'
    set statusline+=\ {%{&ff}}
endif
set statusline+=\ %.80F

" set statusline+=%y\ {%{&ff}}\ %.30F " [filetype] {lineendings} filepath

set statusline+=%= " go to the right side of the status line
set statusline+=\ %l,\ %c " line and column
set statusline+=\ \|\ %p\ %%\ %L " location percentage of the file % line count
