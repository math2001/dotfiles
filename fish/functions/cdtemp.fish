function cdtemp
    set dir (mktemp -d)
    set old (pwd)
    cd "$dir"
    fish
    cd "$old"
    rm -rf "$dir"
end
