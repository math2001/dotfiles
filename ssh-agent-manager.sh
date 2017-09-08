if [[ ! -f ~/.ssh-agent-code ]] || [[ $(ps -a | grep ssh-agent) == '' ]]; then
    echo '[sam] Create new ssh agent'
    ssh-agent > ~/.ssh-agent-code
fi

eval $(cat ~/.ssh-agent-code) > /dev/null

if [[ $(ssh-add -l) == "The agent has no identities." ]]; then
    ssh-add -t 86400
fi
