#!/bin/bash
hyprctl reload
killall ags ydotool
ags &
hyprctl dispatch split:grabroguewindows

