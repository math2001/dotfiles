set encoding=utf-8 fileencoding=utf-8
set nocompatible

if has('gui_running')
    set runtimepath +=$HOME/.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/Colorizer'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

call plug#end()

syntax on
filetype plugin indent on
colorscheme apprentice
highlight TabLine ctermfg=Grey

" Plugins Options {{{

let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnippets"
let g:UltiSnipsSnippetsDirectories = ["UltiSnippets"]
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" }}}

" Tabulation
set tabstop=4 shiftwidth=4 shiftround
set wildmenu wrap cursorline
set smarttab expandtab copyindent autoindent
set backspace=indent,eol,start

set nobackup nowritebackup noswapfile
set backupdir=~/vimtmp,.
set directory=~/vimtmp,.

set formatoptions-=cro " prevent vim from auto inserting comment symbols

set ignorecase smartcase

set scrolloff=2

" Folding

set foldenable foldcolumn=0 foldmethod=syntax

set number relativenumber numberwidth=5
set incsearch nohlsearch showmode showcmd

set showtabline=2
set laststatus=2

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

" that's how you learn
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
    if !empty(glob("~/.gvimrc")) 
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
highlight CursorLine cterm=NONE ctermbg=236

highlight ColorColumn ctermbg=magenta

"" Tabs

" highlight Comment ctermfg=DarkGrey
