
syntax enable

set tabstop=4
set shiftwidth=4
set expandtab

set number relativenumber

set incsearch
set hlsearch

set listchars=tab:>~,nbsp:_,trail:.,eol:¬
set list


" key bindings

imap jj <esc>

" Remap ctrl+W for hyper
nnoremap <C-e> <C-w>


autocmd BufWritePost .vimrc source ~/.vimrc

" Style

highlight NonText ctermfg=DarkGrey

"" Tabs
highlight TabLineFill ctermfg=DarkGray
highlight TabLine     ctermfg=Red  ctermbg=Black
highlight TabLineSel  ctermfg=Green   ctermbg=Black
