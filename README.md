# dotfiles

This setup is inspired by https://github.com/xero/dotfiles

## Installation

```bash
git clone \
    --recursive \
    git@github.com:antonyoneill/dotfiles \
    ~/dotfiles

stow -d ~/dotfiles/*
```

If you forget the `--recursive` you'll get warnings when vim is loaded. You'll have to run the following command to load the submodule

```bash
git submodule update
```

## GPG

I found that the documentation for GPG forwarding was disjointed. It appears that systemctl on Ubuntu automatically starts the gpg-agent, this overrides the RemoteForward socket, preventing the remote agent working correctly.

Best bet I found was to disable the gpg-agent.service, and the various sockets.

```bash
systemctl --user \
	mask --now \
	gpg-agent.service \
	gpg-agent.socket \
	gpg-agent-ssh.socket \
	gpg-agent-extra.socket \
	gpg-agent-browser.socket
```
