#!/usr/bin/env bash

###############################################################################
# laptop-power.sh
# This script runs in tandem of the systemd service file in
# $HOME/.config/systemd/user/powermonitor.service
#
# The script will watch your battery for power events and automatically adjust
# the power profile depending on your battery power level.  It uses inotifywait
# which can be installed with inotity-tools.
###############################################################################

BAT=$(echo /sys/class/power_supply/BAT0)
BAT_STATUS="$BAT/status"
BAT_CAP="$BAT/capacity"
LOW_BAT_PERCENT=40

AC_PROFILE="performance"
BAT_PROFILE="balanced"
LOW_BAT_PROFILE="battery"

# wait a while if needed
[[ -z $STARTUP_WAIT ]] || sleep "$STARTUP_WAIT"

# start the monitor loop
prev=0

while true; do
	# read the current state
	if [[ $(cat "$BAT_STATUS") == "Discharging" ]]; then
		if [[ $(cat "$BAT_CAP") -gt $LOW_BAT_PERCENT ]]; then
			profile=$BAT_PROFILE
		else
			profile=$LOW_BAT_PROFILE
		fi
	else
		profile=$AC_PROFILE
	fi

	# set the new profile
	if [[ $prev != "$profile" ]]; then
		system76-power profile $profile
	fi

	prev=$profile

	# wait for the next power change event
	inotifywait -qq "$BAT_STATUS" "$BAT_CAP"
done
