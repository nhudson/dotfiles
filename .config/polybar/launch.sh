#!/usr/bin/env bash
#set -x

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get monitor outputs
for m in $(polybar --list-monitors | cut -d ":" -f1); do
  if [[ $m == "HDMI-1-0" ]]; then
    monitor="$m"
    bar="external"
  else
    monitor="$m"
    bar="edp-1"
  fi

  # Launch polybar
  MONITOR=$monitor polybar $bar -c "$HOME/.config/polybar/config.ini" &
  continue
done
