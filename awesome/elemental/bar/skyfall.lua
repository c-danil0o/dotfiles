 awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require("keys")
local helpers = require("helpers")
local net_widgets = require("net_widgets")

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
    if tag.selected then
        item.markup = helpers.colorize_text(beautiful.taglist_text_focused[index], beautiful.taglist_text_color_focused[index])
    elseif tag.urgent then
        item.markup = helpers.colorize_text(beautiful.taglist_text_urgent[index], beautiful.taglist_text_color_urgent[index])
    elseif #tag:clients() > 0 then
        item.markup = helpers.colorize_text(beautiful.taglist_text_occupied[index], beautiful.taglist_text_color_occupied[index])
    else
        item.markup = helpers.colorize_text(beautiful.taglist_text_empty[index], beautiful.taglist_text_color_empty[index])
    end
end

net_wireless = net_widgets.wireless({interface="wlp1s0"})
    
    local create_button = function (symbol, color, bg_color, hover_color)
    local widget = wibox.widget {
        font = "icomoon 16",
        align = "center",
        id = "text_role",
        valign = "center",
        markup = helpers.colorize_text(symbol, color),
        widget = wibox.widget.textbox()
    }

    local section = wibox.widget {
        widget,
        forced_width = dpi(60),
        bg = bg_color,
        widget = wibox.container.background
    }

    -- Hover animation
    section:connect_signal("mouse::enter", function ()
        section.bg = hover_color
    end)
    section:connect_signal("mouse::leave", function ()
        section.bg = bg_color
    end)

     helpers.add_hover_cursor(section, "hand1")

    return section
end


--menu sandwitch
local sandwich = create_button("", x.color4, x.color8.."30", x.color8.."50")

sandwich:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("launcher")
    end),
    awful.button({ }, 3, function ()
        dashboard_show()
    end)
)) 
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        layout = wibox.layout.fixed.horizontal,
        widget_template = {
            widget = wibox.widget.textbox,
            create_callback = function(self, tag, index, _)
                self.align = "center"
                self.valign = "center"
                self.forced_width = dpi(25)
                self.font = beautiful.taglist_text_font

                update_taglist(self, tag, index)
            end,
            update_callback = function(self, tag, index, _)
                update_taglist(self, tag, index)
            end,
        },
        buttons = keys.taglist_buttons
    }

    -- Create a system tray widget
    s.systray = wibox.widget.systray()

    -- Create a wibox that will only show the tray
    -- Hidden by default. Can be toggled with a keybind.
    s.traybox = wibox({visible = false, ontop = true, shape = helpers.rrect(dpi(10)), type = "dock"})
    s.traybox.width = dpi(200)
    s.traybox.height = dpi(50)
    s.traybox.x = 1710
    --s.traybox.y = 50
    s.traybox.y = 40
    s.traybox.bg = x.background
    s.traybox.border_color = x.color2
    s.traybox.border_width = dpi(2)
    s.traybox:setup {
        s.systray,
        left = dpi(6),
        right = dpi(6),
        top = dpi(8),
        bottom = dpi(8),
        
        widget = wibox.container.margin
    }
    s.traybox:buttons(gears.table.join(
        -- Middle click - Hide traybox
        awful.button({ }, 2, function ()
            s.traybox.visible = false
        end)
    ))
    -- Hide traybox when mouse leaves
    s.traybox:connect_signal("mouse::leave", function ()
        s.traybox.visible = false
    end)

     -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
  
    s.mylayoutbox.resize = true
    s.mylayoutbox.opacity = 0.65
    s.mylayoutbox.forced_height = beautiful.wibar_height - dpi(20)
    s.mylayoutbox.background = x.color8

    s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    local exit = create_button("", x.color12, "#282930",x.color8.."E0")
    exit:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        exit_screen_show()
    end)
))
    local volume_symbol = ""
local volume_muted_color = x.color8
local volume_unmuted_color = x.color4
local stray = create_button(volume_symbol, volume_unmuted_color, "#21222", x.color8.."70")
stray:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        s.traybox.visible = true
    end),
    awful.button({ }, 3, function ()
        dashboard_show()
    end)
)) 

local mytextclock = awful.widget.textclock('<span font="Iosevka 14"> %H:%M</span>',12)


    local mybar1 = wibox.widget{
                {
                    sandwich,
                    spacing = dpi(12),
                s.mytaglist,
                spacing = dpi(12),
                layout = wibox.layout.fixed.horizontal
                },
                
        
        forced_width = dpi(335),
        bg = x.background,
        shape = helpers.rrect(dpi(9)),
        border_width = dpi(01),
        shape_border_color = x.color4..10,
        widget = wibox.container.background
        -- height = beautiful.wibar_height - 5
    }
    local mybar3 = wibox.widget{
        {


                mytextclock,
                left = dpi(5),
                layout = wibox.container.margin,
                },
                
                
        
        forced_width = dpi(170),
        bg = x.background.."20",
        fg = "#686868",
        shape = helpers.rrect(dpi(12)),
        widget = wibox.container.background
        -- height = beautiful.wibar_height - 5
    }

    local dash2_bar = wibox.widget{
        {
            {

                {
        require("noodle.volumearc"),
        require("noodle.brightnessarc"),
        require("noodle.battery_arc"),
        spacing = dpi(20),
        layout = wibox.layout.flex.horizontal,
    },

        top = dpi(5),
        bottom = dpi(5),
        left = dpi(14),
        right = dpi(7),
        layout = wibox.container.margin,
    },
        {
            --{
               mytextclock, 
             --  right = dpi(10),
              -- layout = wibox.layout.flex.horizontal,
          -- },
            shape = helpers.rrect(dpi(15)),
            bg = "linear:0,0:50,20:0,#61afef:46,#aa88a7",
            fg = x.background,
            forced_width = dpi(65),
            widget = wibox.container.background,
         },
        
        {--spacing = dpi(10),]
            {
            {
                stray,
                net_wireless,
                
                s.mylayoutbox,
                spacing = dpi(8),
                layout = wibox.layout.flex.horizontal,
            },
            top = dpi(4),
            bottom = dpi(4),
            left = dpi(10),
            right = dpi(10),
            layout = wibox.layout.margin
        },
        bg = x.color0,
        shape = helpers.prrect(dpi(10), false,true,true,false),
        widget = wibox.container.background,
        },
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal,
    },
         bg = x.background,
         border_width = dpi(0),
         shape_border_color = x.color4..10,
        forced_width = dpi(340),
        shape = helpers.rrect(dpi(10)),
        widget = wibox.container.background,

    }

    local dash_bar = wibox.widget{
        
            {

                
              {


          require("noodle.volumearc"),
        
         left = dpi(10),
         layout = wibox.container.margin,
     },
      require("noodle.batteryarc"),
         require("noodle.brightnessarc"),

         
         {
            {
               mytextclock, 
               right = dpi(10),
               layout = wibox.container.margin,
           },
            shape = helpers.rrect(dpi(15)),
            bg = x.color4,
            widget = wibox.container.background,
         },
         s.mylayoutbox,
         spacing = dpi(16),

         layout = wibox.layout.fixed.horizontal,
         },
  
         
                
                
        
        forced_width = dpi(300),
        bg = x.background,
        fg = "#686868",


        
        shape = helpers.rrect(dpi(15)),
        widget = wibox.container.background
        -- height = beautiful.wibar_height - 5
    }

    local mybar2 = wibox.widget{
       {
       
        {

            
                {
                  
                    s.mylayoutbox,
                    left = dpi(13),
                    layout = wibox.container.margin,
             },
            
            bg = "#26272E",
            widget = wibox.container.background,
        },
        require("noodle.wifi"),
       
         stray,
         exit, 

         
         
         
        

        
        layout = wibox.layout.flex.horizontal
       },
        
        forced_width = dpi(250),
        bg = x.background,
        shape = helpers.rrect(dpi(12)),
        widget = wibox.container.background
        -- height = beautiful.wibar_height - 5
    }


    local update_tasklist = function (task, c)
    local background = task:get_children_by_id('bg_role')[1]
    local text = task:get_children_by_id('text_role')[1]
    if c.minimized then
        color = "#00000000"
    else
        if c.class == "email" then
            color = x.color2
        elseif c.class == "Firefox" then
            color = x.color1
        elseif c.class == "music" then
            color = x.color5
        elseif c.class == "TelegramDesktop" then
            color = x.color2
        elseif c.class == "Thunar" then
            color = x.color3
        elseif c.class == "mpv" then
            color = x.color6
        elseif c.class == "Alacritty" then
            color = x.color4
        else
            color = x.color7
        end
    end
    if client.focus == c then
        text.markup = helpers.colorize_text(text.text, color)
        -- background.bg = color
        background.border_color = color
        background.bg = x.background.."AA"
    else
        text.markup = helpers.colorize_text(text.text, x.foreground)
        background.bg = color
        background.border_color = "#00000000"
    end
end

       s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = keys.tasklist_buttons,
        style    = {
           -- font = beautiful.tasklist_font,
            
            shape = helpers.rrect(dpi(8)),
            shape_border_width = dpi(1),
            bg = x.color1,
            widget = wibox.container.background,
            

            
        },
        layout   = {
             spacing = dpi(10),
             --layout  = wibox.layout.align.horizontal
            
            layout  = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    id     = 'icon_role',
                    align  = "center",
                    resize = true,
                    forced_width = dpi(40),
                    widget = wibox.widget.imagebox,
                },
              
                
                left = dpi(15),
                right = dpi(15),
                -- Add margins to top and bottom in order to force the
                -- text to be on a single line, if needed. Might need
                -- to adjust them according to font size.
                top  = dpi(8),
                bottom = dpi(8),
                widget = wibox.container.margin
              
            },
                    -- shape = gears.shape.rounded_bar,
                    
                  --   shape = helpers.rrect(dpi(8)),
                     --border_width = dpi(2),
                   --id = "bg_role",
                   --bg = x.color1,
                   id = "background_role",
                   
                     
                   widget = wibox.container.background,
                     
             
             --   id = "bg_role",
           -- 
         --shape = gears.shape.rounded_bar,
           -- create_callback = function(self, c, index, objects)
           -- update_tasklist(self, c)
           -- end,
            
            -- update_callback = function(self, c, index, objects)
            --     update_tasklist(self, c)
            -- end,
        },
    }


       pad = wibox.widget.textbox("                         ")
       pad2 =  wibox.widget.textbox(" ")


    -- Create the wibox
    s.mywibox = awful.wibar({ position = top, bg = "#00000000", screen = s, width = dpi(1800), height = beautiful.wibar_height, shape = helpers.rrect(dpi(7))})
    -- Wibar items
    -- Add or remove widgets here
    s.mywibox:setup {
        {
        
           -- sandwich,
            --spacing = dpi(12),
           -- s.mytaglist,
            
            mybar1,
            spacing = dpi(15),
            

            
            layout = wibox.layout.align.horizontal

        },
        {
            s.mytasklist,
           -- forced_width = dpi(800),
            layout = wibox.layout.align.horizontal,
        },

        {
            
            --mybar2,
            spacing = dpi(18),
            dash2_bar,
            layout = wibox.layout.fixed.horizontal
        },

        expand = "none",
       -- fill_space = "none",
        layout = wibox.layout.align.horizontal
    }
end)

local s = mouse.screen
-- Adds an empty wibar under my polybar so that the workarea changes



-- Every bar theme should provide these fuctions
function wibars_toggle()
    local s = awful.screen.focused()
    s.mywibox.visible = not s.mywibox.visible
end
function tray_toggle()
    local s = awful.screen.focused()
    s.traybox.visible = not s.traybox.visible
end
