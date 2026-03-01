#!/usr/bin/env bash

# --- Read options ---

# keys
key_session="$(tmux show-option -gqv '@fzf_manager_session_key')"
key_session="${key_session:-s}"
key_window="$(tmux show-option -gqv '@fzf_manager_window_key')"
key_window="${key_window:-w}"
key_pane="$(tmux show-option -gqv '@fzf_manager_pane_key')"
key_pane="${key_pane:-P}"
# width, height
width="$(tmux show-option -ggv '@fzf_manager_width')"
width="${width:-80%}"
height="$(tmux show-option -ggv '@fzf_manager_height')"
height="${height:-60%}"

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$PLUGIN_DIR/scripts"

tmux bind-key "$key_session" display-popup -E -w $width -h $height -T " tmux-fzf-manager " "$SCRIPT_DIR/session.sh"
tmux bind-key "$key_window" display-popup -E -w $width -h $height -T " tmux-fzf-manager " "$SCRIPT_DIR/window.sh"
tmux bind-key "$key_pane" display-popup -E -w $width -h $height -T " tmux-fzf-manager " "$SCRIPT_DIR/pane.sh"
