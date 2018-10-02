packadd vim-emoji
set completefunc=emoji#complete
setlocal formatoptions-=a
setlocal linebreak
setlocal statusline+=\ \|\ %{wordcount()['words']}\ words
