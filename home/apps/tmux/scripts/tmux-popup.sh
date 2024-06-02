#!/usr/bin/env bash

# take the session name for the popup
session="$(tmux display-message -p '#{session_name}')"

# create popup based on window id
tmux display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E "tmux attach-session -t popup-$session || tmux new-session -s popup-$session"
