function serve -a port
    if test -n "$port"
        python3 -m http.server "$port"
    else
        python3 -m http.server 8000
    end
end
