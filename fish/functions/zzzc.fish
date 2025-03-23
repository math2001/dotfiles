function zzzc
    cat $argv[1] | grep -v '^\s*#' | z3 /dev/stdin
end
