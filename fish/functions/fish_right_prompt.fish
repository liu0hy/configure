
function fish_right_prompt
    set -l status_ $status
    if test $status_ -ne 0
        set_color red
        echo $status_
        set_color normal
    end
end
