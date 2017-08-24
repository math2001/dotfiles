set encoding=utf-8 fileencoding=utf-8
set nocompatible

if has('gui_running')
    set runtimepath +=$HOME/.vim
endif

" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jiangmiao/auto-pairs'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

Plug 'chrisbra/Colorizer'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode'
Plug 'plasticboy/vim-markdown'

Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }

Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-session'

call plug#end()

" }}}

syntax on
filetype plugin indent on
colorscheme apprentice

" Plugins Options {{{

let g:snips_author="Math2001"
let g:table_mode_corner='|'
let NERDSpaceDelims=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0

" }}}


set wildignore+=node_modules/
set virtualedit=onemore " allow the cursor to move past the end of the line by one more char
set path+=css/,js/,* " add every file recursively to path to :find them quickly
set ff=unix " set line endings to be unix
set tabstop=4 shiftwidth=4 shiftround
" completion in command menu, wrap, highlight current line, set terminal
" title, wrap lines
set wildmenu wrap cursorline title linebreak

set smarttab expandtab copyindent autoindent " indentation stuff
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

" keep the cursor away from the top/bottom with 5 lines when possible
set scrolloff=5

set nofoldenable foldcolumn=0 foldmethod=indent

set number relativenumber numberwidth=5 " gutter options
" highlight live when searching, don't highlight the searches when done
set incsearch nohlsearch
" show currently typed letters bellow the status bar
set showcmd

" always show the status line
set laststatus=2


set statusline=

" read only flag
set statusline+=%r

" modified
set statusline+=%{&modified?'*':''} " display a little * if modified

set statusline+=%y\ {%{&ff}}\ %F " [filetype] {lineendings} filepath

set statusline+=%= " go to the right side of the status line
set statusline+=%l,\ %c " line and column
set statusline+=\ \|\ %p\ %%\ %L " location percentage of the file % line count

" default split position when :vsplit :split (feels more natural to me)
set splitbelow splitright

" complete with the words in the dictionnary :D
set complete+=kspell

" disable the mouse if it's available
set mouse-=a

" abbreviations
cabbrev help tab help

augroup autocmds
    au!
    au FileType html iabbrev <buffer> --- &mdash;
    " fix vim bug: open all .md files as markdown
    au BufNewFile,BufRead *.md setlocal filetype=markdown
    " set options for markdown
    au FileType markdown setlocal textwidth=81 | :silent TableModeEnable

    au FileType javascript nnoremap <buffer> <leader>b :!node %<cr>
    au FileType python nnoremap <buffer> <leader>b :!python %<cr>
    au FileType python nnoremap <buffer> <leader>b :!python %<cr>
    au FileType vim nnoremap <buffer> <leader>b :source %<cr>
augroup end

" keybindings

let mapleader=","

" 'cause that's how you learn
inoremap <esc> <nop>
" 'cause I'm lazy...
inoremap jk <esc>

" to consider wrapped lines as actual lines
nnoremap j gj
nnoremap k gk

nnoremap <leader>s :call ScopeInfos()<CR>

" Emmet
imap hh <C-y>,

" clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" surrond the current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>` viw<esc>a`<esc>bi`<esc>lel

" my fuzzy file finder
nnoremap <leader>f :find 

" duplicate selection
vnoremap <leader>d y'>p

" quote the visual selection
vnoremap <leader>" <esc>`<i"<esc>`>la"

nnoremap <silent> <leader>w :call ToggleHighlightWordUnderCursor()<CR>
nnoremap <silent> <leader>W :match none<CR>

nnoremap : ;
nnoremap ; :
vnoremap ; :
vnoremap : ;

nnoremap <leader>ev :call OpenFile($MYVIMRC)<cr>
nnoremap <leader>eb :call OpenFile("~/.bashrc")<cr>

augroup reloadvimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source ~/.vimrc
    if has("gui_running")
        autocmd BufWritePost $MYGVIMRC source ~/.vimrc
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
highlight NonText ctermfg=DarkGrey
highlight SpecialKey ctermfg=DarkGrey
highlight IndentGuidesOdd ctermbg=236
highlight IndentGuidesEven ctermbg=236

" functions

function! OpenFile(file)
    if &columns > 160
        execute "vsplit ".a:file
    else
        execute "tabe ".a:file
    endif
endfunction

function! ScopeInfos()
    let synid = synIDtrans(synID(line('.'), col('.'), 1))
    echo printf('Syntax name: "%s" | fg: %s bg: %s', synIDattr(synid, 'name'),  synIDattr(synid, 'fg#'), synIDattr(synid, 'bg#'))
endfunction

function! Insert(text)
    " a simple function to insert text where the cursor is
    execute "normal! \<Esc>a".a:text
endfunction

function! Strip(text)
    return substitute(a:text, '^\_s*\(.\{-}\)\_s*$', '\1', '')
endfunction

function! ToggleHighlightWordUnderCursor()
    let matches = getmatches()
    let cword = expand('<cword>')
    if !empty(matches) && printf('\<%s\>', cword) ==# matches[0]['pattern']
        match none
        echo "Matches cleared"
    else
        silent! exe printf('match IncSearch /\<%s\>/', cword)
        redir => nbmatches
            silent! exe "%s/".cword."//gn"
        redir END
        let nbmatches = str2nr(Strip(split(nbmatches, ' ')[0]))
        echo printf('Found %s match%s', nbmatches, nbmatches > 1 ? 'es' : '')
        " move cursor back to its previous position
        execute "normal! \<C-o>"
    endif
endfunction

function! EscapeHTML() range
    execute a:firstline.",".a:lastline."s/\</\\&lt;/g"
    execute a:firstline.",".a:lastline."s/\>/\\&gt;/g"
endfunction

" commands

command! RemoveWindowsLineEndings :%s/\r\(\n\)/\1/g
command! Date :call Insert(Strip(system('date +"%A %d %B %Y @ %H:%M"')))
command! -range=% EscapeHTML :call EscapeHTML()

if has('gui_running')
    silent! source ~/.gvimrc
endif
