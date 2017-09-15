set encoding=utf-8 fileencoding=utf-8
set nocompatible
syntax on
filetype plugin indent on

if has('win32') && match(&runtimepath, '/.vim')
    set runtimepath+=$HOME/.vim
endif

" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'
Plug 'cespare/vim-toml'
Plug 'jiangmiao/auto-pairs'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'dhruvasagar/vim-table-mode'
Plug 'plasticboy/vim-markdown'

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'html'] }

Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
" Plug 'othree/html5.vim'

call plug#end()

" }}}

syntax on
filetype plugin indent on

function! Strip(text)
    return substitute(a:text, '^\_s*\(.\{-}\)\_s*$', '\1', '')
endfunction

if Strip(execute('colorscheme')) ==# 'default'
    " Good ones: apprentice, Tomorrow, Tomorrow-night
    let g:gruvbox_bold = 0
    colorscheme apprentice
endif

highlight LineNr ctermbg=235 guibg=#262626
highlight Visual ctermbg=237 ctermfg=NONE guifg=NONE guibg=#3A3A3A cterm=NONE gui=NONE
highlight Cursor gui=reverse guibg=NONE

" Plugins settings {{{

let snips_author = "Math2001"
let table_mode_corner = '|'
let vim_markdown_frontmatter = 1

let netrw_liststyle = 3
let netrw_banner = 0
let netrw_browse_split = 4
let netrw_winsize = 15

let ski_folder = '~/.vim/sessions/'
let ski_update_on_buffer_change = 1

let ctrlp_working_path_mode = 0
let ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

set runtimepath+=~/.vim/plugged/ultisnips

let UltiSnipsExpandTrigger = "<c-h>"
let UltiSnipsListSnippets = "<c-tab>"
let UltiSnipsJumpForwardTrigger = "<c-j>"
let UltiSnipsJumpBackwardTrigger = "<c-k>"

let UltiSnipsEditSplit = "vertical"
let UltiSnipsUsePythonVersion = 3
set runtimepath+=~/dotfiles/vim-snippets/
let UltiSnipsSnippetsDir = "~/dotfiles/vim-snippets/"
let UltiSnipsSnippetsDirectories = ["vim-snippets"]
let UltiSnipsEnabledSnipMate = 0

" set cursor insert/normal in terminal
if !has('gui_running')
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endif

" }}}

" Options

set lazyredraw
set autoread

set noerrorbells " no sound from vim, it's a text editor, not a music player

" Because windows sucks
set shell=sh
set shellcmdflag=-c

set spell spellfile="~/.vim/spell.utf-8.add"

set virtualedit=onemore " allow the cursor to move past the end of the line by one more char
set path=,,*
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

set statusline+=%= " go to the right side of the status line
" set statusline+=%{g:ski_session}\ \|
set statusline+=\ %{wordcount()['words']}\ words\ \|
set statusline+=\ %l,\ %c " line and column
set statusline+=\ \|\ %p\ %%\ %L " location percentage of the file % line count

" default split position when :vsplit :split (feels more natural to me)
set splitbelow splitright

" complete with the words in the dictionary :D
set complete+=kspell

" disable the mouse if it's available
set mouse-=a

" abbreviations
iabbrev lable label
iabbrev teh the

function! FileTypeSetup(name)
    if a:name ==# 'markdown'
        setlocal textwidth=81
        silent TableModeEnable
        nnoremap <buffer> <leader>* viw*esc>a*<esc>bi*<esc>lel
        nnoremap <buffer> <leader>tip :call InsertTipFrontMatter()<CR>
    elseif a:name ==# 'css'
        setlocal tabstop=2 shiftwidth=2
    elseif a:name ==# 'python'
        setlocal colorcolumn=101
        nnoremap <buffer> <leader>b :call Build('python')<cr>
        iabbrev <buffer> yeild yield
    elseif a:name ==# 'html'
        iabbrev <buffer> --- &mdash;
    elseif a:name ==# 'javascript'
        nnoremap <buffer> <leader>b :call Build('node')<cr>
        iabbrev <buffer> len length
    elseif a:name ==# 'sh'
        nnoremap <buffer> <leader>b :call Build('bash')<cr>
    elseif a:name ==# 'vim'
        nnoremap <buffer> <leader>b :source %<cr>
    elseif a:name ==# 'qf'
        nnoremap <buffer> j j
        nnoremap <buffer> k k
    elseif a:name ==# 'gitconfig'
        setlocal nospell
    elseif a:name ==# 'go'
        nnoremap <buffer> <leader>b :call Build('go run ')<CR>
    elseif a:name ==# 'tmux'
        setlocal nospell
    elseif a:name ==# 'yaml'
        setlocal tabstop=2 shiftwidth=2
        setlocal nospell
    endif
endfunction

command! FileTypeSetup call FileTypeSetup(&filetype)

function! Build(buildexe)
    update
    execute "!".a:buildexe." ".substitute(expand('%'), '\\', '/', 'g')
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
inoremap <esc> <Nop>
inoremap <C-a> <HOME>
inoremap <C-e> <END>
inoremap <C-b> <C-o>b
inoremap <C-f> <C-o>w

" 'cause I'm lazy...
inoremap jk <esc>

" to consider wrapped lines as actual lines
nnoremap j gj
nnoremap k gk

nnoremap <leader>s :call ScopeInfos()<CR>

nmap <leader>c m`gcc``

" Emmet
imap hh <C-y>,

" clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" duplicate selection
vnoremap <leader>d y'>p
nnoremap <leader>d mzyyp`zj

nnoremap <leader>q q:kk
nnoremap <leader>r :%s/

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
nnoremap <leader>elv :call DynamicOpen("~/local.vimrc")<cr>
nnoremap <leader>eb :call DynamicOpen("~/.bashrc")<cr>
nnoremap <leader>eg :call DynamicOpen($MYGVIMRC)<cr>

augroup autoreloadconfigfiles
    autocmd!
    autocmd BufWritePost $MYVIMRC\|local.vimrc source ~/.vimrc
    if has("gui_running")
        autocmd BufWritePost $MYGVIMRC source ~/.vimrc
    endif
    autocmd BufWritePost .tmux.conf silent! !tmux source-file ~/.tmux.conf
augroup end


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

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" commands

command! RemoveWindowsLineEndings :%s/\r\(\n\)/\1/g
command! Date :call Insert(Strip(system('date +"%A %d %B %Y @ %H:%M"')))
command! -range=% EscapeHTML :call EscapeHTML()

if has('gui_running') && glob('~/.gvimrc') != ''
    source ~/.gvimrc
endif

if len(globpath('~', 'local.vimrc', 0, 1)) == 1
    source ~/local.vimrc
else
endif

command! HugoDebug :call Insert('<code>{{ printf "%#v" . }}</code>') |
            \ :normal "bbbb"
nnoremap <silent> <leader>h :HugoDebug<CR>

