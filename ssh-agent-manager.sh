function __create_ssh_agent {
    ssh-agent > ~/.ssh-agent-code
}

function __is_right_ssh_pid {
    if [[ ! -z $SSH_AGENT_PID  ]] && ! ps -p $SSH_AGENT_PID &> /dev/null; then
        return 1
    fi
    return 0
}

function __load_ssh_agent {
    # load the current ssh agent running (create one of none exists)
    if [[ -f ~/.ssh-agent-code ]]; then
        eval $(cat ~/.ssh-agent-code) > /dev/null
        if ! __is_right_ssh_pid; then
            __create_ssh_agent
            eval $(cat ~/.ssh-agent-code) > /dev/null
        fi
    else
        __create_ssh_agent
    fi
}

__load_ssh_agent

# if no key is loaded on the ssh, then load one
if [[ $(ssh-add -l) == "The agent has no identities." ]]; then
	echo -e "${RED}No key loaded on ssh agent"
	echo -e "→ Run ${BRIGHT_RED}ssh-add${RED} to add one${RESET}"
fi

# a day
alias ssh-add="ssh-add -t 86400"
