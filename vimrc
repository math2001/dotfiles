"
" global settings
"

let mapleader=","

" sane defaults
set nocompatible
colorscheme darkbase
syntax on

set number
set backspace=indent,eol,start

" indent stuff (4 spaces)
set tabstop=4 shiftwidth=4
" indent after a if for example
set smartindent

" if it's all lower case, ignore case
set smartcase

set notitle
set hlsearch
set splitbelow splitright

augroup global
    au!
    au BufWritePost *vimrc* :source %
augroup END

"
" Add plugins
"

packadd minpac
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('danro/rename.vim')
call minpac#add('tpope/vim-surround')
call minpac#add('fatih/vim-go')

call minpac#add('tpope/vim-commentary')
nnoremap <leader>c gcc

call minpac#add('jiangmiao/auto-pairs')
let g:AutoPairsCenterLine = 0
let g:AutoPairsMultilineClose = 0

set runtimepath+=~/.fzf
call minpac#add('junegunn/fzf.vim')
source ~/dotfiles/vim/fzf-jump-def.vim

call minpac#add('w0rp/ale', {'type': 'opt'})
call minpac#add('tpope/vim-endwise', {'type': 'opt'})
call minpac#add('pangloss/vim-javascript', {'type': 'opt'})
call minpac#add('mzlogin/vim-markdown-toc', {'type': 'opt'})
call minpac#add('mattn/emmet-vim', {'type': 'opt'})
call minpac#add('imjas/vim-python-pep8-indent', {'type': 'opt'})
call minpac#add('hail2u/vim-css3-syntax', {'type': 'opt'})
call minpac#add('duckpunch/vim-python-indent', {'type': 'opt'})
call minpac#add('dhruvasagar/vim-table-mode', {'type': 'opt'})
call minpac#add('dag/vim-fish', {'type': 'opt'})
call minpac#add('boeckmann/vim-freepascal', {'type': 'opt'})

"
" Custom mappings
"

" duplicate lines bellow, keeping track of the cursor position
nnoremap <leader>d mqyyp`qj

nnoremap <leader>ev :tabe ~/dotfiles/vimrc<CR>
nnoremap <leader>et :tabe ~/dotfiles/tmux.conf<CR>

nnoremap L $
nnoremap H ^

"
" Custom commands
"

command! -nargs=? Ftedit execute "tabe ~/.vim/ftplugin/" .
						\ ("<args>" == "" ? &filetype : "<args>") . ".vim"
command! Ftsource execute "tabe ~/.vim/ftplugin".&filetype.".vim"
