set encoding=utf-8 fileencoding=utf-8
set nocompatible

if has('gui_running')
    set runtimepath +=$HOME/.vim
endif

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/Colorizer'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode'

call plug#end()
" }}}

syntax on
filetype plugin indent on
colorscheme apprentice

" Plugins Options {{{

let g:snips_author = "Math2001"

" }}}

" add every file recursively to path to :find them quickly
set path+=**
" set line endings to be unix
set ff=unix
set tabstop=4 shiftwidth=4 shiftround
" completion in command menu, wrap, highlight current line, and set terminal
" title
set wildmenu wrap cursorline title
" Indentation stuff
set smarttab expandtab copyindent autoindent
set backspace=indent,eol,start
set list listchars=tab:»\ ,nbsp:.,trail:·,eol:¬

" Add backkup files in a common directory to not pollute current directory
set nobackup nowritebackup noundofile
set backupdir=$HOME/vimtmp
set directory=$HOME/vimtmp
set undodir=$HOME/vimtmp

 " prevent vim from auto inserting comment symbols
set formatoptions-=cro
" case insensitive if all lower case in search
set ignorecase smartcase

" keep the cursor away from the top/bottom with 2 lines when possible
set scrolloff=2

" Folding

set foldenable foldcolumn=0 foldmethod=syntax

" gutter options
set number relativenumber numberwidth=5
" highlight live when searching, don't highlight the searches when done
set incsearch nohlsearch
" show currently typed letters bellow the status bar
set showcmd

set showtabline=2
set laststatus=2

set statusline=

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

" display file type
set statusline+=%{'\\\'.&ff}\ 
set statusline+=%y\ %F

set statusline+=%= " go to the right side of the status line
set statusline+=%l,\ %c
set statusline+=\ \|\ %p\ %%\ %L

" default split position when :vsplit :split (feels more natural to me)
set splitbelow splitright

" Complete with the words in the dictionnary :D
set complete+=kspell

" abbreviations
cabbrev help tab help

augroup autocmds
    autocmd!
    autocmd FileType html iabbrev <buffer> --- &mdash;
    autocmd FileType gitcommit start

augroup END

" keybindings

let mapleader=","

" 'cause that's how you learn
inoremap <esc> <Nop>
inoremap jk <esc>

" Clipboard

vnoremap <leader>y "+y
nnoremap <leader>p "+p

" quote the current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" quote the visual selection
vnoremap <leader>" <esc>`<i"<esc>`>la"

noremap <C-k> :m .-2<CR>
noremap <C-j> :m .+1<CR>

nnoremap : ;
nnoremap ; :
vnoremap ; :
vnoremap : ;

nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" reload vimrc when saving
augroup reloadgvimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source ~/.vimrc
    if has("gui_running") && !empty(glob("~/.gvimrc")) 
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

highlight CursorLineNr ctermfg=White
highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=236
highlight NonText ctermfg=DarkGrey
highlight SpecialKey ctermfg=DarkGrey

" Commandsj

command! RemoveWindowsLineEndings :%s/\r\(\n\)/\1/g
