function strip {
    # http://stackoverflow.com/a/42106449/6164984
    local STRING=${1#$"$2"}
    echo ${STRING%$"$2"}
}
