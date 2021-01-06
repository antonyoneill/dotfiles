# dotfiles

This setup is inspired by https://github.com/xero/dotfiles

## Installation

```bash

# As a minimum 
sudo apt install git stow vim zsh

# Probably also need gpg key setup
sudo apt install scdaemon

git clone \
    --recursive \
    git@github.com:antonyoneill/dotfiles

cd dotfiles

stow -t ~ */ 
```

If you forget the `--recursive` you'll get warnings when vim is loaded. You'll have to run the following command to load the submodule

```bash
git submodule update --init
```

## GPG

You'll probably forget to import the public key before trying to sign something with the yubikey. The following will find it on the keyserver

```
gpg --keyserver hkp://keyserver.ubuntu.com  --search-keys 2DFFAD3B0C45D8A4
```

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
