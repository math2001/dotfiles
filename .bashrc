if [[ $(uname) != "Linux" ]]; then
    PATH="$PATH:/c/Program Files/Git/bin:C:\Program Files\Git\mingw64\bin"
    alias list='ls --ignore="NTUSER*" --ignore="ntuser.*" --ignore="*.dmp"'
else
    alias list='ls'
fi


RED="\e[0;31m"
GREEN="\e[0;32m"
PURPLE="\e[0;35m"
BLUE="\e[0;34m"
BLACK="\e[0;30m"
GREY="\e[1;30m"
RESET="\e[0m"

function get_stds {
    # get both stdout and stderr to a single string
    TMP=$(mktemp)
    $1 >>"$TMP" 2>&1
    cat "$TMP"
    rm "$TMP"
}

function set_window_title {
    echo -ne "\033]0;$@\007"
}

function is_ssh {
    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        return 0
    fi
    return 1
}

function light_prompt {
    set_window_title "BASH $PWD"
    local EXIT="$?"
    PS1="$BLUE\u@\H$RESET $PURPLE\W$RESET"
    local nbjobs=$(jobs | wc -l)
    if is_ssh; then
        PS1="$GREY[ssh]$RESET $PS1"
    fi
    if [[ $nbjobs != "0" ]]; then
        PS1="\j $PS1"
    fi
    if [[ $EXIT == "0" ]]; then
        PS1="$PS1$GREEN"
    else
        PS1="$PS1$RED"
    fi
    PS1="$PS1 →$RESET "
}

PROMPT_COMMAND=light_prompt

shopt -s autocd dotglob globstar
# insensitive case path completion in bash
bind 'set completion-ignore-case on'

# this makes the autocompletion propose changes, instead of stopping to the ambiguous characters
[[ $- = *i* ]] && bind TAB:menu-complete

alias s="source ~/.bashrc"
alias ls="list -X -A -F --color=auto"
alias ll="ls -lh"
alias cls="echo -e '\\0033\\0143'"
alias findhere="find . -name"
alias grep="grep -i --color=auto"
alias v="vim ~/.vimrc"
alias b="vim ~/.bashrc"
alias j="jobs"

function showcolors {
    for i in `seq 0 1`; do
        for e in `seq 30 37` `seq 40 47`; do
            if [[ $e -eq 40 ]]; then
                echo
            fi
            echo -en "\e[$i;${e}m\\\\e[$i;${e}m$RESET "
        done
        echo 
    done
}

function license {
    if [[ ! -d ~/.licenses ]] || [[ ! -f "$HOME/.licenses/$1" ]]; then
        echo "The file '~/.licenses/$1' doesn't exists"
        return 1
    fi
    cp "$HOME/.licenses/$1" LICENSE
}

function mkcd() {
    mkdir -p "$@" && cd "$@"
}

function bgrun {
    $@ > /dev/null 2>&1 &
}

alias mit='license MIT'
alias st='cd $APPDATA/Sublime\ Text\ 3/Packages'
alias live-serve='browser-sync start --server --files "**/*.html, **/*.css, **/*.js" --no-notify'
alias live-serve-bg='bgrun browser-sync start --server --files "**/*.html, **/*.css, **/*.js" --no-notify'

# git alias

alias gs="git status --short"
alias gl="git log -10 --color --oneline --decorate | goemoji"

# shortcut

bind -x '"\C-f": "ls"'

# exported variables

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# if [[ -f ./run-ssh-agent.sh ]]; then
    # source ./run-ssh-agent.sh
# fi

