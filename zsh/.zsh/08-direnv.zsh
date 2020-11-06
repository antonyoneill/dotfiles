if ! type "direnv" > /dev/null
then
    echo "direnv not installed"
else
    eval "$(direnv hook zsh)"
fi
