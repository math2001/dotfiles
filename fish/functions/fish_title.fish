set current (hostname)
function fish_title
    # the title is set in fish_preexec
    if test ! -z "$last_command"
        set current (echo $last_command | awk '{ print $1 }')
    end
    echo $current@(basename (pwd))
end
