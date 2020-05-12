# Load warp directory (wd)

PLUGIN_DIR="${0:a:h}/plugins/wd"

if [ ! -d "$PLUGIN_DIR" ]
then
	echo "wd not cloned"
else
    wd() {
        source "$PLUGIN_DIR/wd.sh"
    }
fi
