local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
--local active_color = beautiful.battery_bar_active_color or "#5AA3CC"
--local background_color = beautiful.battery_bar_background_color or "#222222"


  local icon = {
        id = "icon",
        image = "/usr/share/icons/Arc/status/symbolic/battery-full-charged-symbolic.svg",
        resize = true,
        opacity = 0.8,
        widget = wibox.widget.imagebox,
    }
local battery_arc = wibox.widget{

 icon,
 
  max_value = 100,
        rounded_edge = true,
        thickness = dpi(2),
        start_angle = 4.71238898, -- 2pi*3/4
   --     forced_height = dpi(20),
        bg = x.background,
        colors = {x.color4},
        paddings = 2,
  widget        = wibox.container.arcchart,
}

awesome.connect_signal("evil::battery", function(value)
    battery_arc.value = value
end)

return battery_arc
