# Set up GPG agent for use in the new shell

export GPG_TTY="$(tty)"

gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye >/dev/null

# Allow remote machines to access the local agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
