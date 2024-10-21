#!/bin/bash

# Check if we're connected to a VM via SSH
if tmux display-message -p '#{pane_current_command}' | grep -o 'ssh'; then
    tmux set-option -g status-bg red
else
    tmux set-option -g status-bg colour50
fi
