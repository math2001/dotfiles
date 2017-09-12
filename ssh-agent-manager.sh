function __create_ssh_agent {
    echo '[sam] Create new ssh agent'
    ssh-agent > ~/.ssh-agent-code
}

function __is_right_ssh_pid {
    if [[ ! -z $SSH_AGENT_PID  ]] && ! ps -p $SSH_AGENT_PID &> /dev/null; then
        return 1
    fi
    return 0
}

function __load_ssh_agent {
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

if [[ $(ssh-add -l) == "The agent has no identities." ]]; then
    ssh-add -t 86400
fi

