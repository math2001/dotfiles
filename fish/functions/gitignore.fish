function gitignore
    for arg in $argv
        echo $arg >> .gitignore
    end
end
