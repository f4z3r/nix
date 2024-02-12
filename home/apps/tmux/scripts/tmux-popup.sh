#!/usr/bin/env bash

# take window id and remove leading @
window="$(tmux display-message -p '#{window_id}')"
window="${window#*@}"

# create popup based on window id
tmux display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E "tmux attach-session -t popup-$window || tmux new-session -s popup-$window"
