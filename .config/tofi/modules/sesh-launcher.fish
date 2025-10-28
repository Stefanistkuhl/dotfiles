#!/usr/bin/env fish
set session (sesh list -t | tofi --prompt " sesh: ")
if [ -n "$session" ]
    $TERMINAL --class sesh -e sesh connect $session
end
