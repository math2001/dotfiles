"
" Add plugins
"

packadd minpac

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/vim-commentary')

nmap <leader>c gcc
vmap <leader>c gc

call minpac#add('danro/rename.vim')
call minpac#add('tpope/vim-surround')
call minpac#add('fatih/vim-go')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('tpope/vim-endwise')
call minpac#add('dag/vim-fish')

let g:AutoPairsCenterLine = 0
let g:AutoPairsMultilineClose = 0

set runtimepath+=~/.fzf
call minpac#add('junegunn/fzf.vim')

source ~/dotfiles/vim/fzf-jump-def.vim
nnoremap <C-P> :Files<CR>

call minpac#add('w0rp/ale', {'type': 'opt'})
let g:ale_sign_column_always = 1
let g:ale_sign_error = "!"
let g:ale_sign_warning = "~"
call minpac#add('pangloss/vim-javascript', {'type': 'opt'})
call minpac#add('mzlogin/vim-markdown-toc', {'type': 'opt'})
call minpac#add('mattn/emmet-vim', {'type': 'opt'})
call minpac#add('imjas/vim-python-pep8-indent', {'type': 'opt'})
call minpac#add('hail2u/vim-css3-syntax', {'type': 'opt'})
call minpac#add('duckpunch/vim-python-indent', {'type': 'opt'})
call minpac#add('dhruvasagar/vim-table-mode', {'type': 'opt'})
call minpac#add('boeckmann/vim-freepascal', {'type': 'opt'})

"
" global settings
"

let mapleader=","
" sane defaults
set nocompatible
filetype plugin indent on
colorscheme darkbase
syntax on

set number
set backspace=indent,eol,start
set wildmenu confirm

" indent stuff (4 spaces)
set tabstop=4 shiftwidth=4
" indent after a if for example
set smartindent

" if it's all lower case, ignore case
set smartcase

set notitle
set hlsearch incsearch
set splitbelow splitright

set hidden noswapfile 
set colorcolumn=80

" see github.com/vim/vim/issues/24
" Reduces the timeout needed when pressing escape and then shift+o
set ttimeoutlen=100

augroup global
    au!
	" automatically source the vimrc when we save
    au BufWritePost *vimrc* :source %
	" automatically source the tmux.conf file when we save
    au BufWritePost *tmux.conf* :silent! !tmux source %
	" get back to the position we were at when we closed same file the file
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g'\"" | endif
augroup END

"
" Custom mappings
"

" don't open the command-line window (use q/ or q? instead)
nnoremap q: :q

" duplicate lines bellow, keeping track of the cursor position
nnoremap <leader>d mqyyp`qj

" open in a split pane/new tab depending on the size of the current buffer. It
" opens in the current buffer is it is empty
function! SmartOpen(path)
	" the buffer is empty
	if expand("%") == "" && &modified == 0
		execute "edit ".a:path
	elseif winwidth(win_getid()) > 160
		" we can fit 2 * 80
		execute "vsplit ".a:path
	else
		execute "tabe ".a:path
	endif
endfunction

nnoremap <leader>ev :call SmartOpen('~/dotfiles/vimrc')<CR>
nnoremap <leader>et :tabe SmartOpen('~/dotfiles/tmux.conf')<CR>

nnoremap L $
nnoremap H ^

" set nohlsearch when going into insert mode.
" Thanks: https://vi.stackexchange.com/a/10415
for s:c in ['a', 'A', '<Insert>', 'i', 'I', 'gI', 'gi', 'o', 'O']
    exe 'nnoremap ' . s:c . ' :nohlsearch<CR>' . s:c
endfor

"
" Custom commands
"

command! -nargs=? Ftedit execute "tabe ~/.vim/ftplugin/" .
						\ ("<args>" == "" ? &filetype : "<args>") . ".vim"
command! Ftsource execute "source ~/.vim/ftplugin/".&filetype.".vim"

