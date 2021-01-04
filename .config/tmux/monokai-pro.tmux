#!/bin/bash
monokai_pro_black="#282c34"
monokai_pro_blue="#9cd1bb"
monokai_pro_yellow="#ffd76d"
monokai_pro_red="#ff657a"
monokai_pro_white="#eaf2f1"
monokai_pro_green="#bad761"
monokai_pro_visual_grey="#3a3b4d"
monokai_pro_comment_grey="#5c6370"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-fg" "$monokai_pro_white"
set "message-bg" "$monokai_pro_black"

set "message-command-fg" "$monokai_pro_white"
set "message-command-bg" "$monokai_pro_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-fg" "$monokai_pro_black"
setw "window-status-bg" "$monokai_pro_black"
setw "window-status-attr" "none"

setw "window-status-activity-bg" "$monokai_pro_black"
setw "window-status-activity-fg" "$monokai_pro_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$monokai_pro_comment_grey"
set "window-active-style" "fg=$monokai_pro_white"

set "pane-border-fg" "$monokai_pro_white"
set "pane-border-bg" "$monokai_pro_black"
set "pane-active-border-fg" "$monokai_pro_green"
set "pane-active-border-bg" "$monokai_pro_black"

set "display-panes-active-colour" "$monokai_pro_yellow"
set "display-panes-colour" "$monokai_pro_blue"

set "status-bg" "$monokai_pro_black"
set "status-fg" "$monokai_pro_white"

set "@prefix_highlight_fg" "$monokai_pro_black"
set "@prefix_highlight_bg" "$monokai_pro_green"
set "@prefix_highlight_copy_mode_attr" "fg=$monokai_pro_black,bg=$monokai_pro_green"
set "@prefix_highlight_output_prefix" "  "

status_widgets=$(get "@monokai_pro_widgets")
time_format=$(get "@monokai_pro_time_format" "%R")
date_format=$(get "@monokai_pro_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$monokai_pro_white,bg=$monokai_pro_black,nounderscore,noitalics]${time_format}  ${date_format} #[fg=$monokai_pro_visual_grey,bg=$monokai_pro_black]#[fg=$monokai_pro_visual_grey,bg=$monokai_pro_visual_grey] #[fg=$monokai_pro_green,bg=$monokai_pro_visual_grey,nobold,nounderscore,noitalics]#[fg=$monokai_pro_black,bg=$monokai_pro_green,bold] #h #[fg=$monokai_pro_yellow, bg=$monokai_pro_green]#[fg=$monokai_pro_red,bg=$monokai_pro_yellow]"
set "status-left" "#[fg=$monokai_pro_visual_grey,bg=$monokai_pro_green,bold] λ #{prefix_highlight}#[fg=$monokai_pro_green,bg=$monokai_pro_black,nobold,nounderscore,noitalics] "

set "window-status-format" "#[fg=$monokai_pro_black,bg=$monokai_pro_black,nobold,nounderscore,noitalics]#[fg=$monokai_pro_white,bg=$monokai_pro_black] #I  #W #[fg=$monokai_pro_black,bg=$monokai_pro_black,nobold,nounderscore,noitalics]"
set "window-status-current-format" "#[fg=$monokai_pro_black,bg=$monokai_pro_visual_grey,nobold,nounderscore,noitalics]#[fg=$monokai_pro_white,bg=$monokai_pro_visual_grey,nobold] #I  #W #[fg=$monokai_pro_visual_grey,bg=$monokai_pro_black,nobold,nounderscore,noitalics]"

