function paru
    if test $argv[1] = "-Sybau"
        command paru -Syu $argv[2..]
    else
        command paru $argv
    end
end
