"
" global settings
"

" sane defaults
set nocompatible
colorscheme darkbase
syntax on

set number

" indent stuff (4 spaces)
set tabstop=4 shiftwidth=4
" indent after a if for example
set smartindent

" if it's all lower case, ignore case
set smartcase

set notitle
set hlsearch

augroup global
    au!
    au BufWritePost *vimrc* :source %
augroup END

"
" Add plugins
"

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('danro/rename.vim')
call minpac#add('tpope/vim-surround')
call minpac#add('fatih/vim-go')

call minpac#add('jiangmiao/auto-pairs')
let g:AutoPairsCenterLine = 0
let g:AutoPairsMultilineClose = 0

set runtimepath+=~/.fzf
call minpac#add('junegunn/fzf.vim')
source ~/dotfiles/vim/fzf-jump-def.vim

"
" Custom mappings
"

let mapleader=","
" duplicate lines bellow, keeping track of the cursor position
nnoremap <leader>d mqyyp`qj
