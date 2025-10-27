function recordcast --description 'Record current shell session using your current shell; Docker UI after'
    # Choose a base filename
    set -l base session
    if test (count $argv) -ge 1
        set base (string replace -ra '[^A-Za-z0-9._-]' '_' -- $argv[1])
    end

    # Next available .cast name
    set -l out "$base.cast"
    set -l n 1
    while test -e "$out"
        set out "$base-$n.cast"
        set n (math $n + 1)
    end

    # Determine which shell to record (prefer your current shell)
    set -l shell_cmd $SHELL
    if test -z "$shell_cmd"
        set shell_cmd fish
    end

    echo "Recording this shell ($shell_cmd). Press Ctrl+D or type 'exit' to stop."
    # Record using the same shell, in login mode, with stdin
    nix run nixpkgs#asciinema -- rec --stdin -c "$shell_cmd -l" "$out"
    set -l rec_status $status
    if test $rec_status -ne 0
        echo "asciinema recording failed (status $rec_status)"
        return $rec_status
    end
end
