set encoding=utf-8 fileencoding=utf-8
set nocompatible

if has('gui_running')
    set runtimepath +=$HOME/.vim
endif

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'chrisbra/Colorizer'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode'
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }

call plug#end()
" }}}

syntax on
filetype plugin indent on
colorscheme apprentice

" Plugins Options {{{

let g:snips_author = "Math2001"
let g:user_emmet_expandabbr_key = ',e'
let g:table_mode_corner = '|'
" }}}


set wildignore+=node_modules/
set virtualedit=onemore " allow the cursor to move past the end of the line by one more char
set path+=css/,js/ " add every file recursively to path to :find them quickly
set ff=unix " set line endings to be unix
set tabstop=4 shiftwidth=4 shiftround
" completion in command menu, wrap, highlight current line, and set terminal
" title
set wildmenu wrap cursorline title
" indentation stuff
set smarttab expandtab copyindent autoindent
set backspace=indent,eol,start
set list listchars=tab:»\ ,nbsp:.,trail:·,eol:¬

" add backkup files in a common directory to not pollute current directory
set backupdir=$HOME/.vim/_backups
set directory=$HOME/.vim/_swapfiles
set undodir=$HOME/.vim/_undos

 " prevent vim from auto inserting comment symbols
set formatoptions-=cro
" case insensitive if all lower case in search
set ignorecase smartcase

" keep the cursor away from the top/bottom with 2 lines when possible
set scrolloff=2

" folding

set nofoldenable foldcolumn=0 foldmethod=syntax

" gutter options
set number relativenumber numberwidth=5
" highlight live when searching, don't highlight the searches when done
set incsearch nohlsearch
" show currently typed letters bellow the status bar
set showcmd

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

" complete with the words in the dictionnary :d
set complete+=kspell

" disable the mouse if it's available
set mouse-=a

" abbreviations
cabbrev help tab help

augroup autocmds
    autocmd!
    autocmd FileType html iabbrev <buffer> --- &mdash;
    " fix vim bug: open all .md files as markdown
    autocmd BufNewFile,BufRead *.md set filetype=markdown
    " set options for markdown
    autocmd FileType markdown setlocal textwidth=81 linebreak | :TableModeEnable

    au FileType javascript nnoremap <buffer> <leader>b :!node %<cr>
    au FileType python nnoremap <buffer> <leader>b :!python %<cr>
augroup end

" keybindings

let mapleader=","

" 'cause that's how you learn
inoremap <esc> <nop>
inoremap jk <esc>

" clipboard

vnoremap <leader>y "+y
nnoremap <leader>p "+p

" quote the current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" duplicate selection
vnoremap <leader>d y'>p

" quote the visual selection
vnoremap <leader>" <esc>`<i"<esc>`>la"

noremap <c-k> :m .-2<cr>
noremap <c-j> :m .+1<cr>

nnoremap : ;
nnoremap ; :
vnoremap ; :
vnoremap : ;

nnoremap <leader>v :vsplit $MYVIMRC<cr>

" reload vimrc when saving
augroup reloadgvimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source ~/.vimrc
    if has("gui_running") && !empty(glob("~/.gvimrc")) 
        source ~/.gvimrc
    endif
augroup end

" save on focus lost
augroup autowrite
    autocmd! BufLeave * silent! update
augroup end

augroup setspell
    autocmd BufRead,BufNewFile *.md setlocal spell
augroup end

" style

highlight CursorLineNr ctermfg=white
highlight CursorLine cterm=none ctermfg=none ctermbg=236
highlight NonText ctermfg=darkgrey
highlight SpecialKey ctermfg=darkgrey


function! Insert(text)
    " a simple function to insert text where the cursor is
    execute "normal! \<Esc>a".a:text
endfunction

function! Strip(text)
    return substitute(a:text, '^\_s*\(.\{-}\)\_s*$', '\1', '')
endfunction
" commands

command! RemoveWindowsLineEndings :%s/\r\(\n\)/\1/g
command! InsertDate :call Insert(Strip(system('date +"%A %d %B %Y @ %H:%M"')))


