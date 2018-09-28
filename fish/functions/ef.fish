function ef --description 'Simply edit a function'
	# make sure we have the right number of arguments
    # echo a friendly message
	set -l count (count $argv)
    set_color red
	if test $count -eq 0
        echo Need a function name
    else if test $count -gt 1
        echo Too many arguments
    end
    set_color normal
    # block if we don't have the right number
    if test $count -ne 1
        return
    end

    # makes sure that the function isn't an alias
    if alias | grep (string join ' ' alias $argv[1] '[\'"]')
        set_color yellow
        echo "$argv[1] is already defined as an alias."
        read -l -P 'Edit anyway? (y/N) ' confirm
        set_color normal
        if test $confirm != 'y' -a $confirm != 'Y'
            echo Aborted.
            return
        end
    end

    # pre-write the function
    set -l path ~/.config/fish/functions/$argv[1].fish
	if test ! -f $path
        set_color yellow
        echo "This function doesn't exists."
        read -l -P 'Write it? (y/N) ' confirm
        set_color normal
        if test "$confirm" != y -a "$confirm" != Y
            echo Aborted.
            return
        end
        echo -e function $argv[1]\n\nend > $path
    end
    # open the editor
	eval $EDITOR $path
    # reload the function
	source $path
	echo 'Function reloaded'
end
