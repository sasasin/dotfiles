if ! test -e ~/.config/fish/functions/fisher.fish
    echo "fisher not exists."
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
    fisher
end