#!/usr/bin/env bash
# ---
# Use "run program" to run it only if it is not already running
# Use "program &" to run it regardless
# ---
# NOTE: This script runs with every restart of AwesomeWM
# If you would like to run a command *once* on login,
# you can use ~/.xprofile

function run {
    if ! pgrep $1 > /dev/null ;
    then
        $@&
    fi
}

# Music
# run mpd
# (Alternatively, enable the mpd service so mpd runs on login)

# Emacs daemon
#run emacs --daemon

# Load terminal colorscheme and settings
xrdb ~/.Xresources

# Urxvt daemon
# run urxvtd -q -o -f

# Mpv input file
if [ ! -e /tmp/mpv.fifo ]; then
    mkfifo /tmp/mpv.fifo
fi

# Desktop effects
run notify-send "test"
run picom  -f --experimental-backend -b --config /home/c_danil0o/.config/picom.conf &

# Enable numlock on login
# Required numlockx to be installed
#run numlockx

# Network manager tray icon
run nm-applet
#run picom
#run gxkb
# Kill redshift processes2
# pkill redshift

# Wallpaper
# (Already set to run in rc.lua)
#~/.fehbg
run xmodmap /home/c_danil0o/.Xmodmap
run kdeconnect-indicator
run xfce4-power-manager
