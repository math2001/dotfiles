function fish_prompt --description 'Write out the prompt'
	set -l last $status
	set_color normal
    # display the number of background jobs
	set -l nbjobs (jobs | wc -l)
	if test $nbjobs -ne 0
        set_color brblack
        echo -n -s $nbjobs ' '
        set_color normal
    end

	# Display the current folder name
	set_color blue;
	if test $PWD = $HOME
        echo -s -n '~'
    else
        echo -n -s (basename $PWD);
    end
	set_color normal

    # Display the current git branch if any
    if set -l gitstatus (git status --short 2>&1)
        if set -l branch (git rev-parse --abbrev-ref HEAD ^&1)
            if test -z "$gitstatus"
                set_color green
            else
                set_color red
            end
            echo -n '' Δ $branch
        end
    end

    # set the sign red/green depending on the exit status of the last command
	if test $last -eq 0
        set_color green
    else
        set_color red
	end
	echo -n ' $ '
	set_color normal
end
