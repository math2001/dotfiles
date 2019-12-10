packadd vim-emoji
packadd vim-table-mode
packadd vim-markdown
silent TableModeToggle
setlocal completefunc=emoji#complete

setlocal formatoptions-=a
setlocal linebreak textwidth=79
if !exists("b:did_ftplugin")
	setlocal statusline+=\ \|\ %{wordcount()['words']}\ words
	let b:did_ftplugin = 1
endif
setlocal spell
