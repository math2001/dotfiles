" jump to function definition
" see https://math2001.github.io/post/vim-jump-to-function-definition
let g:fzf_default_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'}

" returns the user action dict if it exists, otherwise, the default one
function! s:fzf_action()
    if exists('g:fzf_action')
        return g:fzf_action
    else
        return {
            \ 'ctrl-v': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-t': 'vsplit'}
    endif
endfunction

" the callback that is called with one array of length 2:
" args = [ action, line ]
" where the action is the keystroke that the user pressed to select the
" line (ctrl+x, ctrl+v, etc). If he just pressed enter, it's an empty string.
" And the second argument line is the line he selected.
" The array is empty (length 0) if the user cancelled
function! s:fzf_open_file(args)
    " the user pressed ctrl-c, and cancelled
    if len(a:args) == 0
        return
    endif
    let [action, line] = a:args
    " The line is like this: path/to/filename.go:line ...
    " we want the filename, and the line.
    let [filename; rest] = split(line, ":")
    let [line; rest] = split(join(rest), " ")

    " the get(...) get's the action to run, depending on what the user pressed
    " the format is "action +line filename". This automatically jumps to the
    " right line
    exec get(s:fzf_action(), action, 'edit')." +".line." ".filename
endfunction

function! FzfJumpDef(lang) abort
    if a:lang == 'go'
        " gets all the lines starting with 'func ' in .go files
        let l:command = 'ag --go -s "^func " '
        " formats the output
        " seperator is : (not space)
        let l:command .= '| awk -F : '
        let l:command .= "'{ "
        " removes the func and the trailling in the third field {
        let l:command .= "gsub(/(^func )|( {$)/, \"\", $3);"
        " prints $1:$2 $3
        let l:command .= 'printf "%s:%s %s\n", $1, $2, $3'
        let l:command .= " }'"
    else
        throw "Lang ".lang." unknown"
    endif
    " l:command is the command that will fetch all the lines
    " the option --with-nth=2.. hides the first field from the user, but is
    " still given to the callback function
    " so, here, we hide the filename and line.
    " the --expect bit allows the user to press ctrl+t to open in a new tab for
    " example (defined by g:fzf_action)
    echom l:command
    call fzf#run(fzf#wrap({'source': l:command,
            \ 'options': '--with-nth=2.. --expect='.join(keys(s:fzf_action()), ','),
            \ 'sink*': funcref('s:fzf_open_file')}))
endfunction

