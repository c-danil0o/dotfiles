-------------------------------------------------
-- Brightness Widget for Awesome Window Manager
-- Shows the brightness level of the laptop display
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/widget-widget

-- @author Pavel Makhov
-- @copyright 2019 Pavel Makhov
-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local beautiful = require("beautiful")

local PATH_TO_ICON = "/usr/share/icons/Arc/status/symbolic/display-brightness-symbolic.svg"
local GET_BRIGHTNESS_CMD =  "xbacklight -get"
local INC_BRIGHTNESS_CMD =  "xbacklight -inc 5"
local DEC_BRIGHTNESS_CMD = "xbacklight -dec 5"

local brightness_widget = {}

local function worker(user_args)

    local args = user_args or {}

    local get_brightness_cmd = args.get_brightness_cmd or GET_BRIGHTNESS_CMD
    local inc_brightness_cmd = args.inc_brightness_cmd or INC_BRIGHTNESS_CMD
    local dec_brightness_cmd = args.dec_brightness_cmd or DEC_BRIGHTNESS_CMD
    local color = args.color or beautiful.fg_color
    local bg_color = '#ffffff11'
    local path_to_icon = args.path_to_icon or PATH_TO_ICON
    local timeout = args.timeout or 1

    local icon = {
        id = "icon",
        image = path_to_icon,
        resize = true,
        opacity = 0.7,
        widget = wibox.widget.imagebox,
    }

    brightness_widget = wibox.widget {
        icon,
        max_value = 1,
        thickness = 2,
        start_angle = 4.71238898, -- 2pi*3/4
        forced_height = 22,
        forced_width = 18,
        bg = bg_color,
        paddings = 2,
        colors = {x.color4},
        widget = wibox.container.arcchart
    }

    local update_widget = function(widget, stdout)
        local brightness_level = string.match(stdout, "(%d?%d?%d?)")
        brightness_level = tonumber(string.format("% 3d", brightness_level))

        widget.value = brightness_level / 100;
    end

    brightness_widget:connect_signal("button::press", function(_, _, _, button)
        if (button == 4) then
            spawn(inc_brightness_cmd, false)
        elseif (button == 5) then
            spawn(dec_brightness_cmd, false)
        end
    end)

    watch(get_brightness_cmd, timeout, update_widget, brightness_widget)

    return brightness_widget
end

return setmetatable(brightness_widget, { __call = function(_, ...)
    return worker(...)
end })
