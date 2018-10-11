function fish_right_prompt -d "Write out the right prompt"
    if test "$PIPENV_ACTIVE" = "1"
        set_color yellow -o
        echo PIP
        set_color blue
        echo ENV
        set_color normal
        echo " "
    end
    set_color brblack -u
    hostname
    set_color normal
end
