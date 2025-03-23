" sane defaults
set nocompatible
filetype plugin indent on
syntax on
let mapleader=" "
"
"
" Add plugins
"

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O

cnoremap <C-A> <home>

packadd minpac

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/vim-commentary')

nmap <leader>c gcc
vmap <leader>c gc

call minpac#add('tpope/vim-surround')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('danro/rename.vim')
call minpac#add('tpope/vim-fugitive')
call minpac#add('idris-hackers/idris-vim')
" call minpac#add('prabirshrestha/vim-lsp')
" call minpac#add('mattn/vim-lsp-settings')
" call minpac#add('prabirshrestha/asyncomplete.vim')
" call minpac#add('prabirshrestha/asyncomplete-lsp.vim')

" call minpac#add('jiangmiao/auto-pairs')
" call minpac#add('tpope/vim-endwise')
call minpac#add('dag/vim-fish')
" call minpac#add('lifepillar/pgsql.vim')
call minpac#add('junegunn/goyo.vim')
" call minpac#add('leafgarland/typescript-vim')


nnoremap <leader>g :Goyo<cr>
let g:goyo_width = 81

let g:AutoPairsCenterLine = 0
let g:AutoPairsMultilineClose = 0

" set runtimepath+=~/.local/lib/fzf

call minpac#add('junegunn/fzf.vim')
" FIXME: this should be in a local config file, not something that is shared
" across systems
" source /usr/share/doc/fzf/examples/fzf.vim
source ~/.fzf/plugin/fzf.vim

" source ~/dotfiles/vim/fzf-jump-def.vim
function! FzfJumpDef(lang) abort
    if a:lang == 'go'
        execute "normal! :Ag ^func \<cr>"
    else
        echom "Lang" a:lang "unknown."
    endif
endfunction
nnoremap <C-P> :Files<cr>

" call minpac#add('prabirshrestha/async.vim')
" call minpac#add('prabirshrestha/asyncomplete.vim')
let g:asyncomplete_min_chars = 3
" call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
" call minpac#add('prabirshrestha/vim-lsp')
" call minpac#add('mattn/vim-lsp-settings')

nnoremap K :LspHover<cr>
let g:lsp_diagnostics_echo_cursor = 1

" call minpac#add('pangloss/vim-javascript', {'type': 'opt'})
" call minpac#add('mzlogin/vim-markdown-toc', {'type': 'opt'})
" call minpac#add('mattn/emmet-vim', {'type': 'opt'})
" call minpac#add('hail2u/vim-css3-syntax', {'type': 'opt'})
" call minpac#add('duckpunch/vim-python-indent')
" call minpac#add('dhruvasagar/vim-table-mode', {'type': 'opt'})
" call minpac#add('boeckmann/vim-freepascal', {'type': 'opt'})
" call minpac#add('plasticboy/vim-markdown', {'type': 'opt'})

"
" global settings
"

colorscheme default

set number
set backspace=indent,eol,start
set wildmenu confirm

" indent stuff (4 spaces)
set tabstop=4 shiftwidth=4 expandtab
" indent after a if for example
set smartindent autoindent

" if it's all lower case, ignore case
set ignorecase smartcase

set notitle
set hlsearch incsearch
set splitbelow splitright

set hidden noswapfile
set colorcolumn=73
set textwidth=72

set completeopt+=noselect

set scrolloff=2

" set list listchars=tab:\│\ ,nbsp:.,trail:·,eol:¬
set list listchars=tab:\ \ \│,nbsp:.,trail:·

set autowrite

set noeol
set nofixendofline

" see github.com/vim/vim/issues/24
" Reduces the timeout needed when pressing escape and then shift+o
set ttimeoutlen=100

" Hint: use gf (go to file), c-o and c-i to browse
set laststatus=2
source ~/dotfiles/vim/statusline.vim

" don't insert comment prefix on enter or o
set formatoptions-=ro


"
" Custom mappings
"

" don't jump to the first error
nnoremap <leader>b :make!<cr>
"
" Ignore the build output, please, oh fucking please don't take me to
" non-existing files.
cabbrev make make!
cabbrev ag Ag


" highlight the current word. hlsearch needs to be enabled
nnoremap <leader>w #*
nnoremap <leader>W :nohlsearch<cr>

" don't open the command-line window (use q/ or q? instead)
nnoremap q: :q

" duplicate lines bellow, keeping track of the cursor position
nnoremap <leader>d mq"zyy"zp`qj
vnoremap <leader>d mq"zy'>"zp`qj'>j

" open in a split pane/new tab depending on the size of the current buffer. It
" opens in the current buffer is it is empty
function! SmartOpen(path)
	" the buffer is empty
	if expand("%") == "" && &modified == 0
		execute "edit ".a:path
	elseif winwidth(win_getid()) > 160
		" we can fit 2 * 80
		execute "vsplit ".a:path
	else
		execute "tabe ".a:path
	endif
endfunction

function! SwitchCppToH()
    let l:ext = "foo"
    if expand("%:e") == "cpp"
        let l:ext = "h"
    elseif expand("%:e") == "h"
        let l:ext = "cpp"
    else
        echom "need to be in a .h and .cpp file"
        return
    endif
    execute "edit ".expand("%:r").".".l:ext
endfunction

nnoremap <leader>ev :call SmartOpen('~/dotfiles/vimrc')<cr>
nnoremap <leader>et :call SmartOpen('~/dotfiles/tmux.conf')<cr>
nnoremap <leader>h :call SwitchCppToH()<cr>


nnoremap L $
vnoremap L $
onoremap L $
nnoremap H ^
vnoremap H ^
onoremap H ^

nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

nnoremap z. mzz.`z

" set nohlsearch when going into insert mode.
" Thanks: https://vi.stackexchange.com/a/10415
for s:c in ['a', 'A', '<Insert>', 'i', 'I', 'gI', 'gi', 'o', 'O']
    exe 'nnoremap ' . s:c . ' :nohlsearch<cr>' . s:c
endfor

"
" Custom commands/functions
"

command! Size echo line2byte(line('$') + 1)

command! GoLint set makeprg=golint | make | set makeprg=make

command! ProfileMe :profile start profile.log
			\ <bar> profile func *
			\ <bar> profile file *
command! ProfileStop :profile pause

command! -nargs=? FTEdit execute "tabe ~/.vim/after/ftplugin/" .
						\ ("<args>" == "" ? &filetype : "<args>") . ".vim"
command! FTSource execute "source ~/.vim/after/ftplugin/".&filetype.".vim"

function! <SID>insertdate()
	let @z = system("date +'%A %d %B %Y' | tr -d '\n'")
	execute 'normal! "zp'
endfunction

function! <SID>deletefile(name)
    if input("Permanently delete (y/N) ") == "y"
        call delete(a:name)
        q
    endif
endfunction

command! Date call s:insertdate()
command! Delete call s:deletefile(expand("%"))

function! <SID>strip_whitespace()
	let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

highlight NonText ctermfg=Black

augroup global
    au!
	" automatically source the vimrc when we save
    au BufWritePost *vimrc* :source %
	" automatically source the tmux.conf file when we save
    au BufWritePost *tmux.conf* :silent! !tmux source %
	" get back to the position we were at when we closed same file the file
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") &&
                \ expand("%:t") != "COMMIT_EDITMSG"
				\| exe "normal! g'\"" | endif
	au BufWritePre * call s:strip_whitespace()
augroup END

augroup sml
  " au BufRead,BufNewFile *.sml let maplocalleader = "h" | source /home/math2001/.programs/HOL/tools/vim/hol.vim
  au BufRead,BufNewFile *.sml let maplocalleader = "'" | source /home/math2001/.programs/HOL/tools/vim/hol.vim
  au BufRead,BufNewFile *?Script.sml setlocal filetype=hol4script
  " recognise pre-munger files as latex source
  au BufRead,BufNewFile *.htex setlocal filetype=htex syntax=tex
  "Uncomment the line below to automatically load Unicode
  au BufRead,BufNewFile *?Script.sml source /home/math2001/.programs/HOL/tools/vim/holabs.vim
  "Uncomment the line below to fold proofs
  au BufRead,BufNewFile *?Script.sml setlocal foldmethod=syntax foldnestmax=1
augroup END

command! Syn echo synIDattr(synID(line("."), col("."), 1), "name")