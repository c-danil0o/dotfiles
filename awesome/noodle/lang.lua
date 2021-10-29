local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require('beautiful').xresources.apply_dpi
local keys = require("keys")


-- Language switcher
kbdcfg = {}
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.switch = function ()
  current_kb = io.popen("xkb-switch -p -n"):read("*a")
  kbdcfg.widget:set_text(current_kb)
end
kbdcfg.switch()