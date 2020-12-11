# Load warp directory (wd)

WD_PLUGIN_DIR="${0:a:h}/plugins/wd"

if [ ! -d "$WD_PLUGIN_DIR" ]
then
	echo "wd not cloned"
else
    fpath=($WD_PLUGIN_DIR $fpath)

    wd() {
        source "$WD_PLUGIN_DIR/wd.sh"
    }
fi
