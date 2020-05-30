if ! command -v gpgconf >/dev/null 2>&1
then
	echo "gpgconf not installed"
elif (( ! ${+SSH_CLIENT} ))
then
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
