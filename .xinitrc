#!/usr/bin/env bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
   xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
   xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
   xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
   xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [[ ! $(pidof polkit-gnome-authentication-agent-1) ]]; then
	/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# Set s76 power threasholds
# start charging at 86% and stor at 90%
#system76-power charge-thresholds --list-profiles
sudo system76-power charge-thresholds --profile balanced

# Set keyboard
#setxkbmap en &

# Compositor
"$HOME/code/picom/bin/picom-trans" --experimental-backends &

# Notify Daemon
dunst &
#/usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd &

# Set keyboard repeat rate
xset r rate 300 50

# Set mouse acceleration
xinput --set-prop 16 'libinput Accel Speed' -0.420788

if [[ $(cat /proc/acpi/button/lid/LID0/state) == "open" || $(xrandr -q | grep "HDMI-1-0 connected") ]]; then
  ~/.screenlayout/laptop-dual-home.sh
elif [[ $(cat /proc/acpi/button/lid/LID0/state) == "open" ]]; then
  ~/.screenlayout/laptop-only.sh
fi

#exec bspwm
exec dbus-launch --autolaunch=$(cat /var/lib/dbus/machine-id) bspwm
