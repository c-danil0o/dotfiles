#!/bin/bash
hyprctl reload
killall ags
ags &
hyprctl dispatch split:grabroguewindows
