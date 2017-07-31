set nocompatible
set encoding=utf-8 fileencoding=utf-8
syntax enable

" allows session to work both on windows and unix 'at the same time'
set sessionoptions+=unix,slash

" Tabulation
set tabstop=4 shiftwidth=4 shiftround
set smarttab expandtab
set copyindent autoindent
set showmatch matchtime=2

set ignorecase smartcase

set scrolloff=2

set wrap
set number relativenumber
set incsearch
set showmode
set showcmd

set showtabline=2

" display warning line endings aren't unix
set statusline=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

" file type and full file type
set statusline+=%y\ %F

set statusline+=%=
set statusline+=%l,\ %c
set statusline+=\ \|\ %p\ %%\ %L

" default window position when spliting
set splitbelow splitright

set list listchars=tab:»\ ,nbsp:.,trail:·,eol:¬

set complete+=kspell

call matchadd('ColorColumn', '\%81v', 100)

" open help in a new tab, not in a new window
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
nnoremap <F4> :so $VIMRUNTIME/syntax/hitest.vim<cr>

" quote the current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" quote the visual selection
vnoremap <leader>" <esc>`<i"<esc>`>la"

"" Remap ctrl+W for hyper
nnoremap <C-e> <C-w>

" move cursor's line up and down
noremap <C-j> :m .+1<CR>
noremap <C-k> :m .-2<CR>

nnoremap : ;
nnoremap ; :
vnoremap ; :
vnoremap : ;

nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" reload vimrc when saving
augroup MyVimrcReloader
    autocmd!
    autocmd BufWritePost .vimrc source ~/.vimrc
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
