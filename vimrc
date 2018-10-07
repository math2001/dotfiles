" sane defaults
set nocompatible
filetype plugin indent on
let mapleader=","
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
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('tpope/vim-endwise')
call minpac#add('dag/vim-fish')
call minpac#add('lifepillar/pgsql.vim')
call minpac#add('junegunn/goyo.vim')
nnoremap <leader>g :Goyo<cr>
let g:goyo_width = 81

let g:AutoPairsCenterLine = 0
let g:AutoPairsMultilineClose = 0

set runtimepath+=~/.fzf
call minpac#add('junegunn/fzf.vim')

source ~/dotfiles/vim/fzf-jump-def.vim
nnoremap <C-P> :Files<cr>

call minpac#add('junegunn/vim-emoji', {'type': 'opt'})
call minpac#add('w0rp/ale', {'type': 'opt'})

" disable the errors lists.
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_list_window_size = 0
" just lint on save
let g:ale_lint_on_text_changed = 0

nmap <leader>a :ALENextWrap<cr>

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

colorscheme darkbase
syntax on

set number
set backspace=indent,eol,start
set wildmenu confirm

" indent stuff (4 spaces)
set tabstop=4 shiftwidth=4 expandtab
" indent after a if for example
set smartindent autoindent

" if it's all lower case, ignore case
set ignorecase smartcase

set notitle
set hlsearch incsearch
set splitbelow splitright

set hidden noswapfile
set colorcolumn=80

set scrolloff=2

set list listchars=tab:\│\ ,nbsp:.,trail:·,eol:¬

set autowrite

" see github.com/vim/vim/issues/24
" Reduces the timeout needed when pressing escape and then shift+o
set ttimeoutlen=100

" Hint: use gf (go to file), c-o and c-i to browse
set laststatus=2
source ~/dotfiles/vim/statusline.vim

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

" don't jump to the first error
nnoremap <leader>b :make!<cr>
"
" Ignore the build output, please, oh fucking please don't take me to
" non-existing files.
cabbrev make make!


" highlight the current word. hlsearch needs to be enabled
nnoremap <leader>w #*
nnoremap <leader>W :nohlsearch<cr>

" don't open the command-line window (use q/ or q? instead)
nnoremap q: :q

" duplicate lines bellow, keeping track of the cursor position
nnoremap <leader>d mq"zyy"zp`qj
vnoremap <leader>d mq"zy'>"zp`qj'>j

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

nnoremap <leader>ev :call SmartOpen('~/dotfiles/vimrc')<cr>
nnoremap <leader>et :call SmartOpen('~/dotfiles/tmux.conf')<cr>

nnoremap L $
vnoremap L $
onoremap L $
nnoremap H ^
vnoremap H ^
onoremap H ^

nnoremap z. mzz.`z

" set nohlsearch when going into insert mode.
" Thanks: https://vi.stackexchange.com/a/10415
for s:c in ['a', 'A', '<Insert>', 'i', 'I', 'gI', 'gi', 'o', 'O']
    exe 'nnoremap ' . s:c . ' :nohlsearch<cr>' . s:c
endfor

"
" Custom commands/functions
"
command! ProfileMe :profile start profile.log
			\ <bar> profile func *
			\ <bar> profile file *
command! ProfileStop :profile pause

command! -nargs=? FTEdit execute "tabe ~/.vim/ftplugin/" .
						\ ("<args>" == "" ? &filetype : "<args>") . ".vim"
command! FTSource execute "source ~/.vim/ftplugin/".&filetype.".vim"

function! <SID>insertdate()
	let @z = system("date +'%A %d %B %Y' | tr -d '\n'")
	execute 'normal! "zp'
endfunction

function! <SID>deletefile(name)
    if input("Permanently delete (y/N) ") == "y"
        call delete(a:name)
        q
    endif
endfunction

command! Date call s:insertdate()
command! Delete call s:deletefile(expand("%"))

function! <SID>strip_whitespace()
	let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

highlight NonText ctermfg=Black

augroup global
    au!
	" automatically source the vimrc when we save
    au BufWritePost *vimrc* :source %
	" automatically source the tmux.conf file when we save
    au BufWritePost *tmux.conf* :silent! !tmux source %
	" get back to the position we were at when we closed same file the file
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g'\"" | endif
	au BufWritePre * call s:strip_whitespace()
augroup END
