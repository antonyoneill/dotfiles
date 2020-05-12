# Load rvm

RVM_DIR="$HOME/.rvm"

if [ ! -d "$RVM_DIR" ]
then
	echo "rvm not installed"
else
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"

    source "$RVM_DIR/scripts/rvm"
fi
