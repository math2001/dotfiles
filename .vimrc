set nocompatible
syntax enable

" Tabulation
set tabstop=4
set smarttab
set shiftwidth=4
set expandtab
set copyindent
set autoindent
set showmatch matchtime=2
set ignorecase
set smartcase

set scrolloff=2

" Folding

set foldenable
set foldcolumn=1
set foldmethod=syntax

set number relativenumber
set incsearch
set nowrap
set showmode
set showcmd

set showtabline=2

set colorcolumn=85

set statusline=%r
set statusline=%y\ %f
set statusline+=%=
set statusline+=%l,\ %c
set statusline+=\ \|\ %p\ %%\ %L

set listchars=tab:»\ ,nbsp:.,trail:·,eol:¬
set list

set splitbelow
set splitright

set complete+=kspell

call matchadd('ColorColumn', '\%81v', 100)

" keybindings
let mapleader=","

imap jj <esc>
map <F2> :mksession! ~/.vim_session<cr>
map <F3> :source ~/.vim_session <cr>
nmap <leader>c :so $VIMRUNTIME/syntax/hitest.vim<cr>
nnoremap <F4> :so $VIMRUNTIME/syntax/hitest.vim<cr>

"" Remap ctrl+W for hyper
nnoremap <C-e> <C-w>

noremap <C-j> :m .+1<CR>
noremap <C-k> :m .-2<CR>

nnoremap : ;
nnoremap ; :
vnoremap ; :
vnoremap : ;

nnoremap <C-e> <C-w>

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
highlight CursorLine ctermfg=Red ctermbg=DarkGrey

highlight ColorColumn ctermbg=magenta

"" Tabs

highlight TabLineFill ctermfg=DarkGray ctermfg=DarkGrey
highlight TabLine ctermfg=Red ctermbg=DarkGrey
highlight TabLineSel ctermfg=White ctermbg=Black
highlight Comment ctermfg=DarkGrey


