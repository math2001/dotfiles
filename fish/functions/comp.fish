function comp -a filename
    set base (echo "$filename" | sed -E 's/\.[^\.]+$//')
    g++ -Wall -Wextra -o "$base" "$filename"
end
