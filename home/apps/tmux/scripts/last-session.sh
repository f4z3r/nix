#!/usr/bin/env bash

# get current session name
export session="$(tmux display-message -p '#{session_name}')"

# get last session and switch to it
tmux switch-client -t "$(tmux list-sessions -F '#{session_last_attached} #{session_name}' |
        rg -v "quake|popup|notes|$session" |
        sort --numeric-sort --reverse | awk '{print $2}' | head -n1)"
