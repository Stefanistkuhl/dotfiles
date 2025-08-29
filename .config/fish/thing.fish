#! /usr/bin/fish

set -g localDir ~/coding
set -g remoteDir ~/coding
set -g idiotSafeGuard true
set -g host "stefiii@10.0.0.166"
set -g upload false

function usage
    echo "Usage: (script) [-l localDir] [-r remoteDir] [-i] [-h host] [-u]"
    echo ""
    echo "  -l   Set local directory (default: $localDir)"
    echo "  -r   Set remote directory (default: $remoteDir)"
    echo "  -i   Enable idiotSafeGuard (default: $idiotSafeGuard)"
    echo "  -h   Set remote host (default: $host)"
    echo "  -u   Upload mode (default: download mode)"
    exit 0
end

for i in (seq (count $argv))
    switch $argv[$i]
        case -l
            set localDir $argv[(math $i + 1)]
        case -r
            set remoteDir $argv[(math $i + 1)]
        case -i
            set idiotSafeGuard true
        case -h
            set host $argv[(math $i + 1)]
        case -u
            set upload true
        case -\*
            echo "Unknown option: $argv[$i]"
            usage
    end
end

function upload
    if test -z "$selected"
        echo "No selection made. Aborting upload."
        exit 1
    end
    echo "Uploading from $localDir/$selected to $host:$remoteDir"
    rsync -avP -e ssh "$(printf "%s/%s" "$localDir" "$selected")" "$(printf "%s:%s/%s/" "$host" "$remoteDir")"
    exit 0
end

function uploadSafe
    if test -z "$selected"
        echo "No selection made. Aborting safe upload."
        exit 1
    end
    set backup "$selected"_OLD
    echo "Uploading from $localDir/$selected to $host:$remoteDir/$selected (backing up original as $backup)"
    ssh $host "cp -a '$remoteDir/$selected' '$remoteDir/$backup'"
    rsync -avP -e ssh "$(printf "%s/%s" "$localDir" "$selected")" "$(printf "%s:%s/%s/" "$host" "$remoteDir")"
    exit 0
end

function download
    echo "Downloading from $host:$remoteDir to $localDir"
    rsync -avP -e ssh "$(printf "%s:%s/%s/" "$host" "$remoteDir" "$selected")" "$(printf "%s/%s" "$localDir" "$selected")"
    exit 0
end

function downloadSafe
    set backup "$selected"_OLD
    echo "Downloading from $host:$remoteDir to $localDir (backing up original as $backup)"
    cp -a "$localDir/$selected" "$localDir/$backup"
    rsync -avP -e ssh "$(printf "%s:%s/%s/" "$host" "$remoteDir" "$selected")" "$(printf "%s/%s" "$localDir" "$selected")"
    exit 0
end

function main
    set dirs (find $localDir -maxdepth 1 -type d)
    set dirs $dirs[2..-1]
    set localBasenames
    for d in $dirs
        set localBasenames $localBasenames (basename $d)
    end
    if test "$upload" = true
        set -g selected (printf "%s\n" $localBasenames | fzf)
        echo "Selected: $selected"
    end

    set remoteDirs (ssh $host find $remoteDir -maxdepth 1 -type d)
    set remoteDirs $remoteDirs[2..-1]
    set remoteBasenames

    for d in $remoteDirs
        set remoteBasenames $remoteBasenames (basename $d)
    end

    if test "$upload" = false
        set -g selected (printf "%s\n" $remoteBasenames | fzf)
        echo "Selected: $selected"
    end

    if test "$upload" = true
        for n in $remoteBasenames
            if test "$n" = "$selected"
                if test "$idiotSafeGuard" = true
                    uploadSafe
                end
            end
        end
    end
    if test "$upload" = false
        for n in $localBasenames
            if test "$n" = "$selected"
                if test "$idiotSafeGuard" = true
                    downloadSafe
                end
            end
        end
    end

    if test "$upload" = true
        upload
    else
        download
    end
end

main
