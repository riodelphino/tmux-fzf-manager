#!/usr/bin/env bash

default_key_binding="@window_manager_key"
key_binding_option="$(tmux show-option -gqv "$default_key_binding")"
key_binding="${key_binding_option:-j}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

tmux bind-key "$key_binding" display-popup -E -w 80% -h 60% -T " tmux-window-manager " "$SCRIPT_DIR/window.sh"
