function srt
    if test (count $argv) -ne 1
        set_color red
        echo 'Invalid number of argument (should have q)'
        set_color normal
        return
    end
    cd
    vim ~/scratchpad.$argv[1]
    cd -
end
