#!/usr/bin/env bash

include_current=$(tmux show-option -ggv "@fzf_manager_include_current")
include_current=${include_current:-0}

current_index=$(tmux display-message -p '#S')

session_format='#{session_name}|#{session_windows} windows|#{?session_attached,(attached),-}'
window_preview='#{window_index}: #{window_name} #{?window_active,(active),}'
key_reload='ctrl-r'
key_delete='ctrl-d'
key_add='ctrl-a'

list_sessions() {
   if [ "$include_current" = "1" ]; then
      tmux list-sessions -F "$session_format"
   else
      tmux list-sessions -F "$session_format" |
         grep -v "^${current_index}|"
   fi
}

list_sessions |
   fzf --reverse \
      --delimiter='|' \
      --with-nth='{1}' \
      --prompt='-> ' \
      --header='═══ Session Switcher ═══ | Ctrl-R: reload | Ctrl-D: delete | Ctrl-A: new' \
      --header-first \
      --border=rounded \
      --preview="tmux list-windows -t {1} -F '$window_preview'" \
      --preview-window='right:40%:wrap' \
      --bind "$key_reload:reload(list_sessions)" \
      --bind "$key_delete:execute(tmux kill-session -t {1})+reload(list_sessions)" \
      --bind "$key_add:execute(tmux new-session -d)+reload(list_sessions)" \
      --info=inline \
      --layout=reverse |
   awk -F'|' '{print $1}' |
   xargs -r tmux switch-client -t
