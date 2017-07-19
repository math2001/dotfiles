
alias grep="grep --color=auto"

if [[ $(uname) != "Linux" ]]; then
    PATH="$PATH:/c/Program Files/Git/bin:C:\Program Files\Git\mingw64\bin"
    alias ls='ls --ignore="NTUSER*" --ignore="ntuser.*" --ignore="*.dmp"'
fi


RED="\033[0;31m"
GREEN="\033[0;32m"
PURPLE="\033[0;35m"
BLUE="\033[0;34m"
RESET="\033[0m"

HOSTNAME=$(hostname)
USER=$(id -u -n)

function get_stds {
    # get both stdout and stderr to a single string
    TMP=$(mktemp)
    $1 >>"$TMP" 2>&1
    cat "$TMP"
    rm "$TMP"
}


function has_git_is_in_git_repo {

    local status=$(git status 2>/dev/null)
    if [[ $? == 127 ]]; then
        return 1
    fi
    if [[ -z $status ]]; then
        return 1
    fi
    if [[ $status == *fatal:* ]]; then
        return 1
    fi
    return 0
}

function colored_git_branch {

    git_branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
    git_branch="(unnamed branch)"     # detached HEAD

    git_branch=${git_branch##refs/heads/}

    local result=$(git status --short)
    if [[ -z $result ]]; then
        git_branch="$GREEN$git_branch$RESET"
    else
        git_branch="$RED$git_branch$RESET"
    fi

}

function set_prompt {

    LAST_COMMAND_CODE=$?

    PS1="\n$BLUE$USER@$HOSTNAME$RESET $PURPLE${PWD/$HOME/"~"}$RESET"

    if has_git_is_in_git_repo; then
        colored_git_branch
        PS1="$PS1 ($git_branch)"
    fi


    PS1="$PS1\n"
    if [[ $LAST_COMMAND_CODE == "0" ]]; then
        PS1="$PS1$GREEN➜$RESET  "
    else
        PS1="$PS1$RED➜$RESET  "
    fi

}


PS1="➜ "
PROMPT_COMMAND=set_prompt

alias s="source ~/.bashrc"
alias ls="ls -F --color=auto -h"
alias ll="ls -l"

# git alias

alias gs="git status --short"
alias gl="git log -10 --oneline --decorate"