# Color variables

RESET="\033[0m"

# Functions

function add_path {
    PATH="$PATH:$1"
}

function get_stds {
    TMP=$(mktemp)
    $1 >>"$TMP" 2>&1
    cat "$TMP"
    rm "$TMP"
}

function get_prompt_text {

    function get_branch_name {
        # captures the stderr and the stdout
        TMP=$(mktemp)
        git rev-parse --abbrev-ref HEAD >>"$TMP" 2>&1
        cat "$TMP"
        rm "$TMP"
    }

    local TEXT="\n\033[1;35m${PWD/$HOME/"~"}${RESET}"

    local BRANCH="$(get_stds 'git rev-parse --abbrev-ref HEAD')"
    if [[ ( ! "$BRANCH" == *fatal:*) ]]; then
        TEXT="${TEXT} → "
        if [[ $(get_stds "git status -s") == "" ]]; then
            TEXT="${TEXT}\033[1;32m"
        else
            TEXT="${TEXT}\033[1;31m"
        fi
        TEXT="${TEXT}${BRANCH}${RESET}"
    fi
    PS1="$TEXT\n$ "
}

# set window's title
echo -ne "\033]0;Terminal\007"

# Prompt text

PS1='\n$ '
PROMPT_COMMAND=get_prompt_text

# Add paths to $PATH

add_path "/c/Program Files/Git/bin"
add_path "/c/Python34/Scripts"
add_path "/c/Program Files/Sublime Text 3/"

export PATH

export HISTIGNORE="clear"

# Aliases

## Unix commands

alias ls="ls -A -X -F --color --ignore='NTUSER.DAT{*'"
alias find="/usr/bin/find $*"

## Git

alias gs="git status --short"
alias gl="git log --oneline --all --graph --decorate -10 $*"
alias gll="git log --oneline --all --graph --decorate $*"

## Others

alias st="cd '$APPDATA/Sublime Text 3/Packages'"
alias stu="cd $APPDATA/Sublime Text 3/Packages/User"
alias cls="echo -e '\\0033\\0143'"
alias sbr="subl ~/dotfiles/.bashrc"
alias sr.="source ~/.bashrc"
alias ascii-colors='echo "\033[\${intensity};\${nb}m";for((i=30;i<=50;i+=1)); do echo -e "\033[0;${i}m ${i}\033[1m ${i} \033[0m"; done'

shopt -s autocd dotglob

# this makes the autocompletion propose changes, instead of stopping to the ambiguous characters
[[ $- = *i* ]] && bind TAB:menu-complete
