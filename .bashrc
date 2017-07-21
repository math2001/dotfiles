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

function is_ssh {

    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        return 0
    fi
    return 1

}

function set_prompt {

    LAST_COMMAND_CODE=$?

    local LOCATION=${PWD/$HOME/"~"}

    set_window_title "$USERNAME@$HOSTNAME:$LOCATION"

    PS1="\n"
    if is_ssh; then
        PS1="$PS1$GREY[${RESET}ssh$GREY]$RESET "
    fi
    PS1="$PS1$BLUE\u@\h$RESET $PURPLE$LOCATION$RESET"

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

shopt -s autocd dotglob globstar

# this makes the autocompletion propose changes, instead of stopping to the ambiguous characters
[[ $- = *i* ]] && bind TAB:menu-complete

alias s="source ~/.bashrc"
alias ls="list -A -F --color=auto"
alias cls="echo -e '\\0033\\0143'"
alias findhere="find . -name"
alias grep="grep -i --color=auto"
# alias showcolors="for escape in `seq 30 37`; do for em in `seq 0 1`; do echo -en '\e[${em};${escape}m033[${em};${escape}m$RESET'; done; done;"


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

# git alias

alias gs="git status --short"
alias gl="git log -10 --oneline --decorate"

if [[ -f ./run-ssh-agent.sh ]]; then
    source ./run-ssh-agent.sh
fi
