#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch example bar
echo "---" | tee -a /tmp/top_main_display.log /tmp/top_second_display.log

polybar top_main_display 2>&1 | tee -a /tmp/top_main_display.log & disown 
polybar top_second_display 2>&1 | tee -a /tmp/top_second_display.log & disown

echo "Bars launched..."
