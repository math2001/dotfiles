# Color variables

RESET="\033[0m"

source ~/dotfiles/bashfunctions.sh

# Functions

VIRTUAL_ENV_FOLDER_NAME='venv' # this is a convention I've took, nothing more

function add_path {
    PATH="$PATH:$1"
}

function get_stds {
    # get both stdout and stderr to a single string
    TMP=$(mktemp)
    $1 >>"$TMP" 2>&1
    cat "$TMP"
    rm "$TMP"
}

function is_active_virtualenv {
    if [[ "$VIRTUAL_ENV" == "" ]]; then
        return 0
    fi
    echo $VIRTUAL_ENV
}

function is_in_virtualenv {
    # check if the folder $VIRTUAL_ENV_FOLDER_NAME exists for every folder above
    # don't use the dirname command for perf reason
    local FOLDERS
    IFS="/" read -r -a FOLDERS <<< "$PWD"
    CURRENT="$PWD"
    for FOLDER in "${FOLDERS[@]}"
    do
        if [[ -d "$CURRENT/$VIRTUAL_ENV_FOLDER_NAME" ]]; then
            return 0
        fi
        CURRENT="$CURRENT/.."
    done
    return 1

}

function lower_case_drive {
    if [[ "${1:0:1}" != '/' || ( "${1:2:1}" != '/' && ${#1} != 2 ) ]]; then
        echo $1
        return 0
    fi
    CHAR="${1:1:1}"
    echo "${1:0:1}${CHAR,}${1:2}"
}

function is_active_virtualenv {
    if [[ -z ${VIRTUAL_ENV+x} ]]; then
        return 1
    fi
    if [[ $(lower_case_drive $VIRTUAL_ENV) != "$PWD/$VIRTUAL_ENV_FOLDER_NAME" ]]; then
        return 1
    fi

    if [[ ! -d "$PWD/$VIRTUAL_ENV_FOLDER_NAME" ]]; then
        return 1
    fi
}


function set_prompt_text {

    function get_branch_name {
        # captures the stderr and the stdout
        TMP=$(mktemp)
        git rev-parse --abbrev-ref HEAD >>"$TMP" 2>&1
        cat "$TMP"
        rm "$TMP"
    }

    PS1="\n\033[1;35m${PWD/$HOME/"~"}${RESET}"

    local BRANCH="$(get_stds 'git rev-parse --abbrev-ref HEAD')"
    if [[ ( ! "$BRANCH" == *fatal:*) ]]; then
        PS1="${PS1} → "
        if [[ $(get_stds "git status -s") == "" ]]; then
            PS1="${PS1}\033[1;32m" # green
        else
            PS1="${PS1}\033[1;31m" # red
        fi
        PS1="${PS1}${BRANCH}${RESET}"
    fi

    if is_in_virtualenv; then
        PS1="$PS1 working on "
        if is_active_virtualenv; then
            PS1="$PS1\033[1;1m"
        else
            PS1="$PS1\033[1;31m"
        fi
        PS1="$PS1${VIRTUAL_ENV_FOLDER_NAME}$RESET"
    fi

    PS1="$PS1\n$ "
}



# set window's title
echo -ne "\033]0;Terminal\007"

# Prompt text

PS1='\n$ '
PROMPT_COMMAND=set_prompt_text

# Add paths to $PATH

add_path "/c/Program Files/Git/bin"
add_path "/c/Python34/Scripts"
add_path "/c/Program Files/Sublime Text 3/"

export PATH

export HISTIGNORE="clear"

# Aliases

## Unix commands

alias ls="ls -A -X -F --color=auto --ignore='NTUSER.DAT{*'"
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
alias venv-activate="source venv/Scripts/activate"

shopt -s autocd dotglob

# this makes the autocompletion propose changes, instead of stopping to the ambiguous characters
[[ $- = *i* ]] && bind TAB:menu-complete
