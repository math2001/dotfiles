function letsgo
    if test ! -d (pwd)"/bin"
        echo no bin directory, aborting
        return
    end

    set -g letsgo_active true
    set -g _letsgo_original_path $PATH

    functions -c fish_prompt letsgo_old_fish_prompt

    set -gx PATH (pwd)"/bin:$PATH"

    function fish_prompt
        echo -n "(letsgo) "
        echo (letsgo_old_fish_prompt)
    end

    function deactivate
        set -g letsgo_active false
        set -gx PATH $_letsgo_original_path

        functions -e fish_prompt
        functions -c letsgo_old_fish_prompt fish_prompt
        functions -e letsgo_old_fish_prompt
        functions -e deactivate
    end
end
