set -Ux HOSTNAME (hostname)
set -Ux EDITOR vim
set -Ux PS_FORMAT 'pid,state,tname,time,command'
set -Ux FZF_DEFAULT_COMMAND 'fd --type f'
set -Ux PYENV_ROOT "$HOME/.local/share/pyenv"
set -Ux MANWIDTH 80

if set -q INSIDE_GNOME_BUILDER
    set -x COLORSCHEME light
else
    set -x COLORSCHEME dark
end


# a much better color than the old grey thing (at least for my colors)
if test "$COLORSCHEME" = "dark"
    set fish_color_autosuggestion brblack
else
    set fish_color_autosuggestion black
end

if set -q INSIDE_GNOME_BUILDER
    set fish_color_autosuggestion brblue
end


set -gx PATH ~/go/bin ~/.gem/ruby/2.5.0/bin ~/.local/bin ~/.cargo/bin $PATH

set -gx ICAROOT "/home/math2001/.local/share/ICAClient/linuxx64"

alias curl "curl -L"
alias ncurl "curl --proxy 'proxy.det.nsw.edu.au:8080' --proxy-ntlm --proxy-user 'mathieu.paturel'"
alias ls "ls -NF --color=auto --group-directories-first"
alias gittips 'gittips ~/.cache/git-tips.json'

alias pip 'echo -e "Do you really want to run pip for python 2.7? Use\n\n    command pip"'

abbr mkdir 'mkdir -p'
abbr mv 'mv -n'
abbr cp 'cp -n'

alias fullbat "upower -i /org/freedesktop/UPower/devices/battery_BAT1"
alias bat "fullbat | command grep 'percentage\|state\|time to'"
alias notepad 'vim -u ~/.vimrc.min'
alias l 'history | head -n 1'
alias types 'cat ~/.local/angular-commit-types'

abbr -a ip 'ip -c'
abbr -a path 'echo $PATH | tr " " "\n" '
abbr -a df 'df -h'
abbr -a du 'du -h'

# git abbreviations
abbr -a gs 'git status --short'
abbr -a gd 'git diff'
abbr -a gc 'git commit'
abbr -a gca 'git commit -a'
abbr -a gl 'git log --oneline -10'
abbr -a gal 'git log --oneline --decorate --graph --all'

abbr -a i ipython
abbr -a j json_pp

abbr -a todo 'vim ~/todo.md'
abbr -a h heroku
abbr -a g grep

abbr -a grip 'grip --quiet . 0.0.0.0:9997'

abbr -a e 'vim ~/.config/fish/config.fish'
abbr -a s 'source ~/.config/fish/config.fish'

abbr -a activate 'source .venv/bin/activate.fish'
abbr -a a 'source .venv/bin/activate.fish'

abbr -a pysc 'python -i -c "import numpy as np; import pandas as pd;"'

abbr -a gcc 'gcc -Wall -Wextra -Werror'

abbr -a dedent 'xclip -selection clipboard -o | python -c "import textwrap,sys; print(textwrap.dedent(sys.stdin.read()))" | xclip -selection clipboard -i'
abbr -a unindent dedent

abbr -a books 'vim ~/Ebooks/books'

abbr -a unsw 'ssh z5312157@cse.unsw.edu.au'
abbr -a gp 'git pull origin HEAD --ff-only'

abbr -a duh 'du -h -d 1 . | sort -hr'

function export_last_command --on-event fish_preexec
    set -g last_command $argv
end

# if test -n "$argv"
    # exec bash -l $argv
# else if status is-interactive; and ! set -q TMUX; and ! test "$TERM_PROGRAM" = "vscode"
    # exec tmux
# end

if ! test -z "$TMUX"
    tmux set-option destroy-unattached
end
