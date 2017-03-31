function strip {
    # http://stackoverflow.com/a/42106449/6164984
    local STRING=${1#$"$2"}
    echo ${STRING%$"$2"}
}

function get_stds {
    # get both stdout and stderr to a single string
    TMP=$(mktemp)
    $1 >>"$TMP" 2>&1
    cat "$TMP"
    rm "$TMP"
}
