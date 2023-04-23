if test -n "$ASDF_DATA_DIR" -a -d "$ASDF_DATA_DIR"
    source $ASDF_DATA_DIR/asdf.fish
end

if test -e ~/.asdf/asdf.fish
    source ~/.asdf/asdf.fish
end
