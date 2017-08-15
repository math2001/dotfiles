set guifont=Monaco
set belloff=all " remove the bells
set guioptions -=m " hides the menu
set guioptions -=T " hides the toolbar
set guioptions -=e " display tab like in a terminal, not using the gui version
set guioptions -=L " hide the left hand scrollbar
set guioptions -=r " hides de right end scrollbar

set lines=999 columns=999
" simalt ~x
au GUIEnter * simalt ~x

colorscheme nova

augroup reloadgvimrc
    autocmd!
    autocmd BufWritePost .gvimrc source ~/.gvimrc
augroup END

function! HI(...)
    " highlight helper
    let string = "highlight ".a:1
    if !empty(a:2)
        let string .= " guifg=".a:2
    endif
    if exists("a:3")
        let string .= " guibg=".a:3
    endif
    exec string
endfunction

let g:terminal_color_0_1 = "#5F7D86"
let g:terminal_color_0_1 = "#465862"

call HI("LineNr", g:terminal_color_8, g:terminal_color_0_1)
call HI("CursorLineNr", "white", g:terminal_color_0_1)
call HI("SignColumn", "", g:terminal_color_0_1)