#!/usr/bin/env bash

window="$(tmux display-message -p '#S')"
tmux display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E "tmux attach-session -t popup-$window || tmux new-session -s popup-$window"
