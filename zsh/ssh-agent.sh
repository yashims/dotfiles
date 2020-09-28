
# Share ssh-agent between terminals.
function start-ssh-agent() {
    if [[ -S "$SSH_AUTH_SOCK" ]]; then
        case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
            ln -fs $SSH_AUTH_SOCK $HOME/.ssh/agent.sock && export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
            echo 'SSH Agent is forwarded!'
            ;;
        *)
            echo 'SSH Agent is already started with Forward Agent.'
            ;;
        esac
    elif [[ -S $HOME/.ssh/agent.sock ]]; then
        export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
        echo 'SSH Agent is already started!'
    else
        echo 'Launch SSH Agent'
        eval `ssh-agent -a $HOME/.ssh/agent.sock`
    fi
}

start-ssh-agent
