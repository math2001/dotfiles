function clip
    if test -z "$argv[1]"
        echo "out or in" > /dev/stderr
        return 1
    end
    if test $argv[1] = "out"
        xclip -selection clipboard -o
    else if test $argv[1] = "in"
        xclip -selection clipboard -i
    else
        echo "in our out"
        return 1
    end
end
