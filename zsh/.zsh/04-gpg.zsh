if ! command -v gpgconf >/dev/null 2>&1
then
	echo "gpgconf not installed"
elif (( ${+WSLENV} ))
then
	# SSH Socket
	# Removing Linux SSH socket and replacing it by link to wsl2-ssh-pageant socket
	export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock 
	ss -a | grep -q $SSH_AUTH_SOCK 
	if [ $? -ne 0 ]; then
		  rm -f $SSH_AUTH_SOCK
		    setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/.ssh/wsl2-ssh-pageant.exe" &>/dev/null &!
	fi
	# GPG Socket
	# Removing Linux GPG Agent socket and replacing it by link to wsl2-ssh-pageant GPG socket
	export GPG_AGENT_SOCK=$HOME/.gnupg/S.gpg-agent 
	ss -a | grep -q $GPG_AGENT_SOCK 
	if [ $? -ne 0 ]; then
		  rm -rf $GPG_AGENT_SOCK
		    setsid nohup socat UNIX-LISTEN:$GPG_AGENT_SOCK,fork EXEC:"$HOME/.ssh/wsl2-ssh-pageant.exe --gpg S.gpg-agent" &>/dev/null &!
	fi
elif (( ${+SSH_CLIENT} ))
then
    agent_path="/run/user/$(id -u)/gnupg/S.gpg-agent"

    old_agent="$(find $agent_path -not -mmin -2)"

    if [[ -n "$old_agent"  && "$SHLVL" -eq 1 ]]
    then
        echo "Cleaning old forwarded agent. Reconnect"
        rm -rf "$agent_path"
        exit
    fi
else
 	# Allow remote machines to access the local agent
	unset SSH_AGENT_PID
	if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	fi

    function gpg-tty {
        # Set up GPG agent for use in the new shell
        export GPG_TTY="$(tty)"
        gpg-connect-agent updatestartuptty /bye >/dev/null
    }

    gpg-tty
fi
