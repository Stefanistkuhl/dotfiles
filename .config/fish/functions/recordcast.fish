function recordcast --description 'Record current shell session using your current shell; Docker UI after'
    # Image/container config
    set -l image svgpicker
    set -l container svgpicker
    set -l server_url http://localhost:5173

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

    # Ensure Docker is available
    if not type -q docker
        echo "Error: docker not found in PATH"
        return 127
    end

    # Build image if missing
    if not docker image inspect $image >/dev/null 2>&1
        echo "Building $image image..."
        docker build -t $image .
        or return 1
    end

    # Remove any container using host port 5173 (whatever its name)
    for name in (docker ps -a --format '{{.Names}} {{.Ports}}' | awk '/0\.0\.0\.0:5173->|:5173->/ {print $1}')
        if test -n "$name"
            echo "Removing conflicting container on port 5173: $name"
            docker rm -f "$name" >/dev/null 2>&1
        end
    end
    # Remove our named container if present
    docker rm -f $container >/dev/null 2>&1

    # Start UI container detached
    echo "Starting container '$container' detached, serving casts from $PWD ..."
    docker run -d --name $container \
        -p 5173:5173 \
        -e APP_DIR=/app \
        -e CASTS_DIR=/casts \
        -v "$PWD":/casts \
        $image >/dev/null
    or begin
        echo "Failed to start container"
        return 1
    end

    # Wait briefly for health
    for i in (seq 1 20)
        if curl -fsS --max-time 0.3 "$server_url/health" >/dev/null 2>&1
            break
        end
        sleep 0.2
    end

    # Open page with the newly recorded cast preloaded
    set -l url "$server_url/?cast="(string escape --style=url "$out")
    echo "Opening: $url"
    if type -q xdg-open
        xdg-open "$url" >/dev/null 2>&1 &
    else if type -q open
        open "$url" >/dev/null 2>&1 &
    else
        echo "Open manually: $url"
    end
end
