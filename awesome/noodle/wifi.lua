 

local awful = require('awful')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('noodle.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local helpers = require('helpers')

local PATH_TO_ICONS = os.getenv('HOME') .. '/.config/awesome/icons/wifi/'

local interface = 'wlan0'
local connected = false
local essid = 'N/A'

local create_button = function (icon, color, bg_color, hover_color)
     widgetwf = wibox.widget {
    
    
    valign = "bottom",
    align = "center",
    image = PATH_TO_ICONS.. "wifi-off.svg",
    forced_width = dpi(22),
    --forced_height = dpi(30),
    widget = wibox.widget.imagebox,

--layout = wibox.container.margin(widgetwf, 0, 0, 0)
--layout = wibox.layout.align.horizontal



 
    }
    local section = wibox.widget {

          
           forced_width = dpi(70),
           bg = "#212228",
           widget = wibox.container.background,


          {layout = wibox.container.margin,
          left = 20,
          right = 0,
          top = 3,
          bottom = 5,
          
          widgetwf,},

  
     
          
        
        


       
        
       
        

    }

    -- Hover animation
    section:connect_signal("mouse::enter", function ()
        section.bg = x.color8 .. "90"
    end)
    section:connect_signal("mouse::leave", function ()
        section.bg = "#212228"
    end)

    -- helpers.add_hover_cursor(section, "hand1")

    return section
end





local widget_button = create_button("s", x.color2, "#212228", "#282A36")
widget_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn('applet_network')
      end
    )
  )
)

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
  {
    objects = {widget_button},
    mode = 'outside',
    align = 'right',
    timer_function = function()
      if connected then
        return 'Connected to ' .. essid
      else
        return 'Wireless network is disconnected'
      end
    end,
    preferred_positions = {'right', 'left', 'top', 'bottom'},
    margin_leftright = dpi(8),
    margin_topbottom = dpi(8)
  }
)

local function grabText()
  if connected then
    awful.spawn.easy_async(
      'iw dev ' .. interface .. ' link',
      function(stdout)
        essid = stdout:match('SSID:(.-)\n')
        if (essid == nil) then
          essid = 'N/A'
        end
      end
    )
  end
end

watch(
  "awk 'NR==3 {printf \"%3.0f\" ,($3/70)*100}' /proc/net/wireless",
  5,
  function(_, stdout)
    local widgetIconName = 'wifi-strength'
    local wifi_strength = tonumber(stdout)
    if (wifi_strength ~= nil) then
      connected = true
      -- Update popup text
      local wifi_strength_rounded = math.floor(wifi_strength / 25 + 0.5)
      widgetIconName = widgetIconName .. '-' .. wifi_strength_rounded
      widgetwf.image = (PATH_TO_ICONS .. widgetIconName .. '.png')
    else
      connected = false
      widgetwf.image = (PATH_TO_ICONS .. widgetIconName .. '-off' .. '.png')
    end
    if (connected and (essid == 'N/A' or essid == nil)) then
      grabText()
    end
    collectgarbage('collect')
  end,
  widget
)

widgetwf:connect_signal(
  'mouse::enter',
  function()
    grabText()
  end
)

return widget_button