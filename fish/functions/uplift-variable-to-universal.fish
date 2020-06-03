function uplift-variable-to-universal
    for x in $argv
        if set -q $x
            set -l temp $$x
            set -el $x
            set -eg $x
            set -eU $x
            set -Ux $x $temp
        end
    end
end