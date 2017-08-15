set encoding=utf-8 fileencoding=utf-8
set nocompatible
syntax enable

if has('gui_running')
    set runtimepath -=~/vimfiles
    set runtimepath +=$HOME/.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/Colorizer'
Plug 'scrooloose/nerdtree'

call plug#end()

" Tabulation
set tabstop=4 shiftwidth=4 shiftround
set smarttab expandtab copyindent autoindent
set showmatch matchtime=2 wrap
set backspace=indent,eol,start

set ignorecase smartcase

set scrolloff=2

" Folding

set foldenable foldcolumn=0 foldmethod=syntax

set number relativenumber numberwidth=5
set incsearch showmode showcmd

set showtabline=2

" display warning line endings aren't unix
set statusline=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

set statusline+=%y\ %F

set statusline+=%=
set statusline+=%l,\ %c
set statusline+=\ \|\ %p\ %%\ %L

set splitbelow splitright

set complete+=kspell

call matchadd('ColorColumn', '\%81v', 100)

cabbrev help tab help

" abbreviations

" filetypes

augroup filetype_html
    autocmd!
    autocmd FileType html iabbrev <buffer> --- &mdash;
augroup END

" keybindings

let mapleader=","

inoremap jk <esc>
nnoremap <leader>c :so $VIMRUNTIME/syntax/hitest.vim<cr>

" Clipboard

vnoremap <leader>y "+y
nnoremap <leader>p "+gP

" quote the current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" quote the visual selection
vnoremap <leader>" <esc>`<i"<esc>`>la"

noremap <A-k> :m .-2<CR>
noremap <A-j> :m .+1<CR>

nnoremap : ;
nnoremap ; :
vnoremap ; :
vnoremap : ;

nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" reload vimrc when saving
augroup reloadgvimrc
    autocmd!
    autocmd BufWritePost .vimrc source ~/.vimrc
    if filereadable("./.gvimrc")
        source ~/.gvimrc
    endif
augroup END

" save on focus lost
augroup AutoWrite
    autocmd! BufLeave * silent! update
augroup END

augroup SetSpell
    autocmd BufRead,BufNewFile *.md setlocal spell
augroup END

" Style

highlight NonText ctermfg=DarkGrey
highlight SpecialKey ctermfg=DarkGrey
highlight LineNr ctermfg=DarkGrey
highlight CursorLineNr ctermfg=White

highlight ColorColumn ctermbg=magenta

"" Tabs

highlight TabLineFill ctermfg=DarkGray ctermfg=DarkGrey
highlight TabLine cterm=None ctermfg=DarkGrey ctermbg=DarkGrey
highlight TabLineSel ctermfg=White
highlight Comment ctermfg=DarkGrey
