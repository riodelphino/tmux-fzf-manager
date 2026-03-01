#!/usr/bin/env bash

include_current=$(tmux show-option -ggv "@window_manager_include_current")
include_current=${include_current:-0}

current_session=$(tmux display-message -p '#S')
current_index=$(tmux display-message -p '#I')

window_format='#{window_index}|#{window_name} #{?window_active,(active),}'
pane_format='#{pane_index}: /#{b:pane_current_path} #{?pane_active,(active),}'
key_reload='ctrl-r'
key_delete='ctrl-d'
key_add='ctrl-a'

list_windows() {
   if [ "$include_current" = "1" ]; then
      tmux list-windows -F "$window_format"
   else
      tmux list-windows -F "$window_format" |
         grep -v "^${current_index}|"
   fi
}

list_windows |
   fzf --reverse \
      --delimiter='|' \
      --with-nth=2 \
      --prompt='-> ' \
      --header='═══ Window Switcher ═══ | Ctrl-R: reload | Ctrl-D: delete | Ctrl-A: add' \
      --header-first \
      --border=rounded \
      --preview="tmux list-panes -t {1} -F '$pane_format'" \
      --preview-window='right:40%:wrap' \
      --bind "$key_reload:reload(list_windows)" \
      --bind "$key_delete:execute(tmux kill-window -t {1})+reload(list_windows)" \
      --bind "$key_add:execute(tmux new-window)+reload(list_windows)" \
      --info=inline \
      --layout=reverse |
   awk -F'|' '{print $1}' |
   xargs -r tmux select-window -t
