# Color variables

RESET="\033[0m"

source ~/dotfiles/bashfunctions.sh
source ~/dotfiles/gitmoji

# Functions

VIRTUAL_ENV_FOLDER_NAME='venv' # this is a convention I've took, nothing more

function add_path {
    if [[ $PATH == *$1* ]]; then
        return
    fi
    PATH="$PATH:$1"
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
    title "Bash @" ${PWD/$HOME/"~"} 😄

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
        PS1="$PS1 @ "
        if is_active_virtualenv; then
            PS1="$PS1\033[1;1m"
        else
            PS1="$PS1\033[1;31m"
        fi
        PS1="$PS1${VIRTUAL_ENV_FOLDER_NAME}$RESET"
    fi

    if [[ $GITMOJI_PS1 != false ]]; then
        PS1="$PS1 $(gitmoji)"
    fi
    PS1="$PS1\n$ "

}


# set window's title
function title {
    echo -ne "\033]0;$@\007"
}

# Prompt text
export PS1
PS1='$ '
PROMPT_COMMAND=set_prompt_text

# Add paths to $PATH

add_path "/c/Program Files/Git/bin"
add_path "/c/Python34/Scripts"
add_path "/c/Program Files/Sublime Text 3/"
add_path "/c/Program Files/Git/mingw64/bin"
add_path "~/AppData/Local/hyper/app-1.2.1"

export PATH

export HISTIGNORE="clear"

# Aliases

function mkcd {
    # create a directory if it doesn't already exists and cd into it
    if [[ -z $1 ]]; then
        echo -e '\033[1;31mNo folder has been specified. \033[0;41mAborting.'
        return 1
    fi
    if ! [[ -d $1 ]]; then
        mkdir $1
    fi
    cd $1
}

alias path="echo $PATH"

## Unix commands

alias ls="ls -A -X -F --color=auto --ignore='NTUSER.DAT{*'"
alias find="/usr/bin/find $*"

## Git

alias gs="git status --short"
alias glc="git log --color=always"
# git log
alias gl="glc --oneline --graph --decorate -10 $* | goemoji"
# git long log
alias gll="glc --oneline --graph --decorate $* | goemoji"
# git multi log
alias gml="glc --oneline --graph --all --decorate -10 $* | goemoji"

## Others

alias st="cd '$APPDATA/Sublime Text 3/Packages'"
alias stu="cd '$APPDATA/Sublime Text 3/Packages/User'"
alias cdhyper="cd '$APPDATA/../local/hyper/app-1.2.1'"
alias cls="echo -e '\\0033\\0143'"
alias sbr="subl ~/dotfiles/.bashrc"
alias sr.="source ~/.bashrc"
alias ascii-colors='echo "\033[\${intensity};\${nb}m";for((i=30;i<=50;i+=1)); do echo -e "\033[0;${i}m ${i}\033[1m ${i} \033[0m"; done'
alias venv-activate="source venv/Scripts/activate"
alias findhere="find . -name $*"

alias mit='license mit > LICENSE'
# alias serve='python -m http.server 8765'

shopt -s autocd dotglob globstar

# this makes the autocompletion propose changes, instead of stopping to the ambiguous characters
[[ $- = *i* ]] && bind TAB:menu-complete
