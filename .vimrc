" Todo
" Run last command with bang :bang
" Tip difference map noremap

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
Plug 'plasticboy/vim-markdown'

Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }

Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
" Plug 'xolox/vim-session'
Plug 'tpope/vim-surround'

call plug#end()

" }}}

syntax on
filetype plugin indent on

function! Strip(text)
    return substitute(a:text, '^\_s*\(.\{-}\)\_s*$', '\1', '')
endfunction

if Strip(execute('colorscheme')) ==# 'default'
    " Good ones: apprentice, Tomorrow, Tomorrow-night
    colorscheme apprentice
endif

" Plugins Options {{{

let snips_author = "Math2001"
let table_mode_corner = '|'
let vim_markdown_frontmatter = 1

let NERDSpaceDelims = 1

let indent_guides_enable_on_vim_startup = 1
let indent_guides_guide_size = 1
let indent_guides_auto_colors = 0

" let session_directory = '~/.vim/sessions/'
" let session_autoload = 'yes'
" let session_autosave = 'yes'

let ski_track_map = '~/.vim/sessions/'

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" }}}

" Settings

" Because windows sucks
set shell=sh
set shellcmdflag=-c

set spell spellfile="~/.vim/spell.utf-8.add"

set wildignore+=node_modules/
set virtualedit=onemore " allow the cursor to move past the end of the line by one more char
set path+=css/,js/,* " add every file recursively to path to :find them quickly
set ff=unix " set line endings to be unix
set tabstop=4 shiftwidth=4 shiftround
" completion in command menu, wrap, highlight current line, set terminal
" title, wrap lines
set wildmenu wrap title linebreak
set confirm " AWESOME!!

set smarttab expandtab copyindent autoindent " indentation stuff
set backspace=indent,eol,start
set list listchars=tab:»\ ,nbsp:.,trail:·,eol:¬

" add backup files in a common directory to not pollute current directory
set backupdir=$HOME/.vim/_backups
set directory=$HOME/.vim/_swapfiles
set undofile undodir=$HOME/.vim/_undos

" prevent vim from auto inserting comment symbols
set formatoptions-=cro

" case insensitive if all lower case in search
set ignorecase smartcase

" highlight current line
set cursorline

" keep the cursor away from the top/bottom with 5 lines when possible
set scrolloff=5

set nofoldenable foldcolumn=0 foldmethod=indent

set number numberwidth=5 " gutter options
" highlight live when searching, don't highlight the searches when done
set incsearch nohlsearch
" show currently typed letters bellow the status bar
set showcmd

" always show the status line
set laststatus=2

set statusline=

set statusline+=%{&readonly?'R':''}
set statusline+=%{&modifiable==0?'-':''}
set statusline+=%{&modified?'*':''}

set statusline+=%y\ {%{&ff}}\ %.30F " [filetype] {lineendings} filepath

function! GetSessionName()
    silent! let sessionname = split(substitute(v:this_session,'\\','/','g'),'/')[-1]
    if !exists('sessionname')
        return '??'
    endif
    if sessionname[-4:] ==? '.vim'
        let sessionname = sessionname[:-5]
    return sessionname
endfunction

set statusline+=%= " go to the right side of the status line
set statusline+=%{GetSessionName()}\ \|
set statusline+=\ %{wordcount()['words']}\ words\ \|
set statusline+=\ %l,\ %c " line and column
set statusline+=\ \|\ %p\ %%\ %L " location percentage of the file % line count

" default split position when :vsplit :split (feels more natural to me)
set splitbelow splitright

" complete with the words in the dictionnary :D
set complete+=kspell

" disable the mouse if it's available
set mouse-=a

" abbreviations
cabbrev help tab help
cabbrev set setlocal
iabbrev lable label
iabbrev teh the

function! FileTypeSetup(name)
    if a:name ==# 'markdown'
        setlocal textwidth=81
        silent TableModeEnable
        nnoremap <buffer> <leader>* viw*esc>a*<esc>bi*<esc>lel
        nnoremap <buffer> <leader>tip :call InsertTipFrontMatter()<CR>
        setlocal nonumber foldcolumn=1
    elseif a:name ==# 'python'
        setlocal colorcolumn=101
        nnoremap <buffer> <leader>b :call Build('python')<cr>
    elseif a:name ==# 'html'
        iabbrev <buffer> --- &mdash;
    elseif a:name ==# 'javascript'
        nnoremap <buffer> <leader>b :call Build('node')<cr>
        iabbrev <buffer> len length
    elseif a:name ==# 'vim'
        nnoremap <buffer> <leader>b :source %<cr>
    elseif a:name ==# 'qf'
        nnoremap <buffer> j j
        nnoremap <buffer> k k
    endif
endfunction

command! FileTypeSetup call FileTypeSetup(&filetype)

function! Build(buildexe)
    update
    execute "!".a:buildexe." ".substitute(expand('%'), '\\', '/', '')
endfunction

augroup autocmds
    au!
    " fix vim bug: open all .md files as markdown
    au BufNewFile,BufRead *.md setlocal filetype=markdown
    au FileType * call FileTypeSetup(expand('<amatch>'))
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

" do not exit visual selection when indenting

vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

nnoremap <leader>s :call ScopeInfos()<CR>

" Emmet
imap hh <C-y>,

" clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" surround the current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>` viw<esc>a`<esc>bi`<esc>lel

" my fuzzy file finder
nnoremap <leader>f :find 
nnoremap <leader>tf :tabfind 

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

nnoremap z. mzz.`z
" don't save to register when using x
nnoremap x "_x

nnoremap <leader>ev :call DynamicOpen($MYVIMRC)<cr>
nnoremap <leader>eb :call DynamicOpen("~/.bashrc")<cr>
nnoremap <leader>eg :call DynamicOpen($MYGVIMRC)<cr>

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

" style

highlight CursorLineNr ctermfg=white guifg=white
highlight CursorLine cterm=none ctermfg=none ctermbg=236
highlight NonText ctermfg=DarkGrey
highlight SpecialKey ctermfg=DarkGrey
highlight IndentGuidesOdd ctermbg=236
highlight IndentGuidesEven ctermbg=236

" functions

function! GetFormattedDate()
    return Strip(system("date +'%A %d %B %Y @ %H:%M'"))
endfunction

function! BangLastCommand()
    let lastcommand = split(@:, ' ')
    let command = lastcommand[0] . '! ' . join(lastcommand[1:], ' ')
    execute command 
endfunction

command! Please call BangLastCommand()

function! InsertTipFrontMatter()
    let date = GetFormattedDate()
    call Insert("---\ntitle: \nslug: \ntags: \ndate: ".date."\nplace: \n---\n\n")
    execute "normal! ?title:\<CR>A "
    start
endfunction

function! DynamicOpen(file)
    if winwidth(win_getid()) > 160
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

if has('gui_running') && glob('~/.gvimrc') != ''
    source ~/.gvimrc
endif
