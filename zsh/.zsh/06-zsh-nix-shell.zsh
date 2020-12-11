# Load zsh-nix-shell

PLUGIN_DIR="${0:a:h}/plugins/zsh-nix-shell"

if [ ! -d "$PLUGIN_DIR" ]
then
	echo "zsh-nix-shell not cloned"
else
    source "$PLUGIN_DIR/nix-shell.plugin.zsh"
fi
