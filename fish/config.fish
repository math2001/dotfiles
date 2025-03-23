set -Ux HOSTNAME (hostname)
set -Ux EDITOR vim
set -Ux PS_FORMAT 'pid,state,tname,time,command'
set -Ux PYENV_ROOT "$HOME/.local/share/pyenv"
set -Ux MANWIDTH 80

export FZF_DEFAULT_OPTS='--no-color'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git ."

set fish_color_autosuggestion brblack


set -gx PATH /usr/local/go/bin ~/.gem/ruby/2.5.0/bin ~/.local/bin ~/.cargo/bin ~/go/bin ~/.local/include/npm-global/bin/ /opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf/bin/ /opt/riscv/bin/ $PATH

set -gx ICAROOT "/home/math2001/.local/share/ICAClient/linuxx64"

# https://gitlab.gnome.org/GNOME/vte/-/issues/2551
set -u VTE_VERSION
set -u COLORTERM

abbr -a py python3
alias curl "curl -L"
alias ncurl "curl --proxy 'proxy.det.nsw.edu.au:8080' --proxy-ntlm --proxy-user 'mathieu.paturel'"
alias ls "ls -NF --color=auto --group-directories-first"
alias gittips 'gittips ~/.cache/git-tips.json'
alias dpython3 'python3 -m pdb -c continue'
# abbr emacs 'emacs -nw'

alias umple='java -jar /home/math2001/.programs/umple-1.31.1.5860.78bb27cc6.jar'

# alias pip 'echo -e "Do you really want to run pip for python 2.7? Use\n\n    command pip"'

abbr mkdir 'mkdir -p'
abbr ckitv ./ckit -I minsys --verify
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
abbr -a agf 'ag -F'
abbr -a g gdb --args

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

abbr -a grip 'grip --quiet . 0.0.0.0:9997'

abbr -a cpcc 'g++ -std=c++11 -O2 -Wall'
abbr -a container 'make -C /home/math2001/work/trustworthy-systems/seL4-CAmkES-L4v-dockerfiles user HOST_DIR=$PWD'

abbr -a e 'vim ~/.config/fish/config.fish'
abbr -a s 'source ~/.config/fish/config.fish'

abbr -a activate 'source .venv/bin/activate.fish'
abbr -a a 'source .venv/bin/activate.fish'

abbr -a pysc 'python -i -c "import numpy as np; import pandas as pd;"'

abbr -a create-typescript-app 'cp ~/code/web/typescript-app .'

# abbr -a gcc 'gcc -Wall -Wextra -Werror'
abbr -a linode ssh '(read line; echo $line)@172.105.183.203 -p 22343'

abbr -a dedent 'xclip -selection clipboard -o | python -c "import textwrap,sys; print(textwrap.dedent(sys.stdin.read()))" | xclip -selection clipboard -i'
abbr -a unindent dedent

abbr -a books 'vim ~/Ebooks/books'

abbr -a unsw 'ssh z5312157@cse.unsw.edu.au'
abbr -a ts 'ssh vb-101'
abbr -a gp 'git pull origin (git rev-parse --abbrev-ref HEAD) --ff-only'
abbr -a gm 'git checkout master'

abbr -a duh 'du -h -d 1 . | sort -hr'
abbr -a uni 'cd ~/Documents/uni/year-2/'

abbr -a t gnome-terminal

abbr -a lisp 'rlwrap sbcl'

abbr -a sdiff 'smerge mergetool'
abbr -a phys 'python3 -i ~/physics.py'

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
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.elan/bin/ $HOME/.cabal/bin $PATH /home/math2001/.ghcup/bin # ghcup-env


if test "$TERMINUS_SUBLIME" = 1; and pwd | grep sublimehq/ckit > /dev/null
    alias mckit="make; and ckit"
    alias gckit="make; and gdb --args ckit"
end

if test "$TERMINUS_SUBLIME" = 1
    export TERM=linux
end

if test "$TERMINUS_SUBLIME" = 1; and test "$TERMINAL_THEME" = light
    # export TERM=xterm-256color
end

# opam configuration
source /home/math2001/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
zoxide init fish | source

eval (opam env)
