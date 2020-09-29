
# Share ssh-agent between terminals.
function start-ssh-agent() {
    SOKET_FILE="$HOME/.ssh/agent.sock"

    if [[ -S "$SSH_AUTH_SOCK" ]]; then
        case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
            ln -fs $SSH_AUTH_SOCK $SOKET_FILE && export SSH_AUTH_SOCK=$SOKET_FILE
            echo 'SSH Agent is forwarded!'
            ;;
        *)
            echo 'SSH Agent is already started with Forward Agent.'
            ;;
        esac
    elif [[ -S $HOME/.ssh/agent.sock ]]; then
        export SSH_AUTH_SOCK=$SOKET_FILE
        echo 'SSH Agent is already started!'
    else
        echo 'Launch SSH Agent'
        eval `ssh-agent -a $SOKET_FILE`
    fi
}

start-ssh-agent
