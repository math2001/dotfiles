function mgcc
    gcc -Wall -Wextra -Werror $argv[1].c -o $argv[1]
    return $status
end
