local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local bling = require("bling")
local theme_name = "ephemeral"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/layout/"
local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/titlebar/"
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/taglist/"
local tip = titlebar_icon_path --alias to save time/space
local xrdb = xresources.get_current_theme()
-- local theme = dofile(themes_path.."default/theme.lua")
local theme = {}

-- Set theme wallpaper.
-- It won't change anything if you are using feh to set the wallpaper like I do.
theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/wallpaper.jpg"
-- A blurred version of your wallpaper would be nice
theme.wallpaper_lock = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/wallpaper_lock.jpg"

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars etc.
-- theme.font          = "sans 11"
theme.font          = "TerminessTTF 10"

-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

theme.bg_dark       = x.background
theme.bg_normal     = x.color0
theme.bg_focus      = x.color8
theme.bg_urgent     = x.color8 
theme.bg_minimize   = x.color8
theme.bg_systray    = x.background

theme.fg_normal     = x.color8
theme.fg_focus      = x.color4
theme.fg_urgent     = x.color3
theme.fg_minimize   = x.color8

-- Gaps
theme.useless_gap   = dpi(5)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(8)

-- Borders
theme.border_width  = dpi(2)
 theme.border_color = x.color_border
theme.border_normal = x.color_border
theme.border_focus  = x.color_border
-- Rounded corners
theme.border_radius = dpi(0)

-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled = false
theme.titlebar_size = dpi(27)
theme.titlebar_title_enabled = true
theme.titlebar_font = "FantasqueSansMono Nerd Font 10"
-- Window title alignment: left, right, center
theme.titlebar_title_align = "center"
-- Titlebar position: top, bottom, left, right
theme.titlebar_position = "top"
--theme.titlebar_bg = "#63c3f7"
 theme.titlebar_bg = "#1D1F28"
theme.titlebar_bg_focus = "#242530"
 theme.titlebar_bg_normal = "#202228"
theme.titlebar_fg_focus = "#8564BB"
theme.titlebar_fg_normal = "#565656"
theme.titlebar_fg = x.color7

-- Notifications
-- ============================
-- Note: Some of these options are ignored by my custom
-- notification widget_template
-- ============================
-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle
theme.notification_position = "top_right"
theme.notification_border_width = dpi(0)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = x.color10
theme.notification_bg = x.background
-- theme.notification_bg = x.color8
theme.notification_fg = x.foreground
theme.notification_crit_bg = x.background
theme.notification_crit_fg = x.color1
theme.notification_icon_size = dpi(60)
-- theme.notification_height = dpi(80)
-- theme.notification_width = dpi(300)
theme.notification_margin = dpi(16)
theme.notification_opacity = 1
theme.notification_font = "sans 12"
theme.notification_padding = theme.screen_margin * 2
theme.notification_spacing = theme.screen_margin * 2

--[[ Bling theme variables template

This file has all theme variables of the bling module.
Every variable has a small comment on what it does.
You might just want to copy that whole part into your theme.lua and start adjusting from there.

--]]


-- window swallowing
theme.dont_swallow_classname_list    = {"firefox", "Gimp"}      -- list of class names that should not be swallowed
theme.dont_swallow_filter_activated  = true                     -- whether the filter above should be active 

-- flash focus
theme.flash_focus_start_opacity = 0.6       -- the starting opacity
theme.flash_focus_step = 0.01               -- the step of animation

-- tabbed
theme.tabbed_spawn_in_tab = false           -- whether a new client should spawn into the focused tabbing container 

-- tabbar general
theme.tabbar_ontop  = false
theme.tabbar_radius = 0                     -- border radius of the tabbar
theme.tabbar_style = "default"              -- style of the tabbar ("default", "boxes" or "modern")
theme.tabbar_font = "Sans 11"               -- font of the tabbar
theme.tabbar_size = 40                      -- size of the tabbar
theme.tabbar_position = "top"               -- position of the tabbar
theme.tabbar_bg_normal = "#000000"          -- background color of the focused client on the tabbar
theme.tabbar_fg_normal = "#ffffff"          -- foreground color of the focused client on the tabbar
theme.tabbar_bg_focus  = "#1A2026"          -- background color of unfocused clients on the tabbar
theme.tabbar_fg_focus  = "#ff0000"          -- foreground color of unfocused clients on the tabbar

-- mstab
theme.mstab_bar_ontop = false               -- whether you want to allow the bar to be ontop of clients
theme.mstab_dont_resize_flaves = false      -- whether the tabbed stack windows should be smaller than the
                                            -- currently focused stack window (set it to true if you use
                                            -- transparent terminals. False if you use shadows on solid ones
theme.mstab_bar_padding = "default"         -- how much padding there should be between clients and your tabbar
                                            -- by default it will adjust based on your useless gaps. 
                                            -- If you want a custom value. Set it to the number of pixels (int)
theme.mstab_border_radius = 0               -- border radius of the tabbar
theme.mstab_bar_height = 40                 -- height of the tabbar
theme.mstab_tabbar_position = "top"         -- position of the tabbar (mstab currently does not support left,right)
theme.mstab_tabbar_style = "default"        -- style of the tabbar ("default", "boxes" or "modern")
                                            -- defaults to the tabbar_style so only change if you want a
                                            -- different style for mstab and tabbed

-- the following variables are currently only for the "modern" tabbar style 
theme.tabbar_color_close = "#f9929b"        -- chnges the color of the close button
theme.tabbar_color_min   = "#fbdf90"        -- chnges the color of the minimize button
theme.tabbar_color_float = "#ccaced"        -- chnges the color of the float button



-- Edge snap
theme.snap_shape = gears.shape.rectangle
theme.snap_bg = x.foreground
theme.snap_border_width = dpi(3)

-- Tag names
theme.tagnames = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
}

-- Widget separator
theme.separator_text = "|"
--theme.separator_text = " :: "
--theme.separator_text = " ??? "
-- theme.separator_text = " ?????? "
theme.separator_fg = x.color8

-- Wibar(s)
-- Keep in mind that these settings could be ignored by the bar theme
theme.wibar_position = "bottom"
theme.wibar_height = dpi(34)
theme.wibar_fg = x.color7
theme.wibar_bg = x.background
--theme.wibar_opacity = 0.7
theme.wibar_border_color = x.color0
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = dpi(0)
theme.wibar_width = dpi(700)

theme.prefix_fg = x.color8

 --There are other variable sets
 --overriding the default one when
 --defined, the sets are:
 --taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
 --tasklist_[bg|fg]_[focus|urgent]
 --titlebar_[bg|fg]_[normal|focus]
 --tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
 --mouse_finder_[color|timeout|animate_timeout|radius|factor]
 --prompt_[fg|bg|fg_cursor|bg_cursor|font]
 --hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
 --Example:
--theme.taglist_bg_focus = "#ff0000"

 --Tasklist
theme.tasklist_disable_icon = false
theme.tasklist_font = "TerminessTTF Nerd Font 10"
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = x.background
theme.tasklist_fg_focus = x.color2
theme.tasklist_bg_normal = x.background
theme.tasklist_fg_normal = x.color15
theme.tasklist_bg_minimize = x.background..12
theme.tasklist_fg_minimize = theme.fg_minimize
theme.tasklist_bg_urgent = x.color0
theme.tasklist_fg_urgent = x.color3
theme.tasklist_spacing = dpi(5)
theme.tasklist_align = "center"
theme.tasklist_shape_border_width = dpi(2)
theme.tasklist_shape_border_color_focus = x.color4
theme.tasklist_shape_border_color = x.color_border
theme.tasklist_shape_border_color_minimized = x.background

-- Sidebar
-- (Sidebar items can be customized in sidebar.lua)
theme.sidebar_bg = x.background
theme.sidebar_fg = x.color7
theme.sidebar_opacity = 0.8
theme.sidebar_position = "left" -- left or right
theme.sidebar_width = dpi(300)
theme.sidebar_x = 0
theme.sidebar_y = 0
theme.sidebar_border_radius = dpi(8)
-- theme.sidebar_border_radius = theme.border_radius

-- Exit screen
theme.exit_screen_bg = x.color0 .. "CC"
theme.exit_screen_fg = x.color7
theme.exit_screen_font = "sans 20"
theme.exit_screen_icon_size = dpi(180)

-- Lock screen
theme.lock_screen_bg = x.color0 
theme.lock_screen_fg = x.color7

-- Icon taglist
local ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, ntags do
  theme.taglist_icons_empty[i] = "/home/danilo_c/.config/awesome/themes/ephemeral/taglist/" .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = "~/danilo_c/.config/awesome/themes/ephemeral/taglist/" .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i] = "~/danilo_c/.config/awesome/themes/ephemeral/taglist/" .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i] = "~/danilo_c/.config/awesome/themes/ephemeral/taglist/" .. tostring(i) .. "_urgent.png"
end

-- Noodle Text Taglist
theme.taglist_text_font = "FontAwesome 11"
theme.taglist_text_empty    = {"???", "???","???","???","???","???","???","???","???","???"}
theme.taglist_text_occupied = {"???","???","???","???","???","???","???","???","???","???"}
theme.taglist_text_urgent  = {"???","???","???","???","???","???","???","???","???","???"}

theme.taglist_text_focused  = {"???","???","???","???","???","???","???","???","???","???"}


--theme.taglist_text_urgent   = {"???","???","???","???","???","???","???","???","???","???"}
-- theme.taglist_text_urgent   = {"???","???","???","???","???","???","???","???","???","???"}
--theme.taglist_text_urgent   = {"???","???","???","???","???","???","???","???","???","???"}



theme.taglist_text_color_empty  = { x.foreground.."60", x.foreground.."60", x.foreground.."60", x.foreground.."60", x.foreground.."60", x.foreground.."60", x.foreground.."60", x.foreground.."60", x.foreground.."60", x.foreground.."60" }
-- theme.taglist_text_color_occupied  = { x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0" }
-- theme.taglist_text_color_focused  = { x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0" }
-- theme.taglist_text_color_urgent  = { x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground }

theme.taglist_text_color_occupied  = { x.color1, x.color2, x.color3, x.color4, x.color5, x.color6, x.color1, x.color2, x.color3, x.color4 }
theme.taglist_text_color_focused  = { x.color1, x.color2, x.color3, x.color4, x.color5, x.color6, x.color1, x.color2, x.color3, x.color4 }
theme.taglist_text_color_urgent   = { x.color7, x.color7, x.color7, x.color7, x.color7, x.color7, x.color7, x.color7, x.color7, x.color7 }
-- theme.taglist_text_color_urgent   = { x.color9, x.color10, x.color11, x.color12, x.color13, x.color14, x.color9, x.color10, x.color11, x.color12 }

-- Prompt
theme.prompt_fg = x.color12

-- Text Taglist (default)
theme.taglist_font = "monospace bold 9"
theme.taglist_bg_focus = x.background
theme.taglist_fg_focus = x.color12
theme.taglist_bg_occupied = x.background
theme.taglist_fg_occupied = x.color8
theme.taglist_bg_empty = x.background
theme.taglist_fg_empty = x.background
theme.taglist_bg_urgent = x.background
theme.taglist_fg_urgent = x.color3
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming the menu:
-- theme.menu_submenu_icon = icons.submenu
theme.menu_height = dpi(35)
theme.menu_width  = dpi(180)
theme.menu_bg_normal = x.color0
theme.menu_fg_normal= x.color7
theme.menu_bg_focus = x.color8 .. "55"
theme.menu_fg_focus= x.color7
theme.menu_border_width = dpi(0)
theme.menu_border_color = x.color0

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Titlebar buttons
-- Define the images to load
theme.titlebar_close_button_normal = tip .. "close_normal.svg"
theme.titlebar_close_button_focus  = tip .. "close_focus.svg"
theme.titlebar_minimize_button_normal = tip .. "minimize_normal.svg"
theme.titlebar_minimize_button_focus  = tip .. "minimize_focus.svg"
theme.titlebar_ontop_button_normal_inactive = tip .. "ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = tip .. "ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = tip .. "ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = tip .. "ontop_focus_active.svg"
theme.titlebar_sticky_button_normal_inactive = tip .. "sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = tip .. "sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = tip .. "sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  = tip .. "sticky_focus_active.svg"
theme.titlebar_floating_button_normal_inactive = tip .. "floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = tip .. "floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = tip .. "floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = tip .. "floating_focus_active.svg"
theme.titlebar_maximized_button_normal_inactive = tip .. "maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  = tip .. "maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = tip .. "maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  = tip .. "maximized_focus_active.svg"
-- (hover)
theme.titlebar_close_button_normal_hover = tip .. "close_normal_hover.svg"
theme.titlebar_close_button_focus_hover  = tip .. "close_focus_hover.svg"
theme.titlebar_minimize_button_normal_hover = tip .. "minimize_normal_hover.svg"
theme.titlebar_minimize_button_focus_hover  = tip .. "minimize_focus_hover.svg"
theme.titlebar_ontop_button_normal_inactive_hover = tip .. "ontop_normal_inactive_hover.svg"
theme.titlebar_ontop_button_focus_inactive_hover  = tip .. "ontop_focus_inactive_hover.svg"
theme.titlebar_ontop_button_normal_active_hover = tip .. "ontop_normal_active_hover.svg"
theme.titlebar_ontop_button_focus_active_hover  = tip .. "ontop_focus_active_hover.svg"
theme.titlebar_sticky_button_normal_inactive_hover = tip .. "sticky_normal_inactive_hover.svg"
theme.titlebar_sticky_button_focus_inactive_hover  = tip .. "sticky_focus_inactive_hover.svg"
theme.titlebar_sticky_button_normal_active_hover = tip .. "sticky_normal_active_hover.svg"
theme.titlebar_sticky_button_focus_active_hover  = tip .. "sticky_focus_active_hover.svg"
theme.titlebar_floating_button_normal_inactive_hover = tip .. "floating_normal_inactive_hover.svg"
theme.titlebar_floating_button_focus_inactive_hover  = tip .. "floating_focus_inactive_hover.svg"
theme.titlebar_floating_button_normal_active_hover = tip .. "floating_normal_active_hover.svg"
theme.titlebar_floating_button_focus_active_hover  = tip .. "floating_focus_active_hover.svg"
theme.titlebar_maximized_button_normal_inactive_hover = tip .. "maximized_normal_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover  = tip .. "maximized_focus_inactive_hover.svg"
theme.titlebar_maximized_button_normal_active_hover = tip .. "maximized_normal_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover  = tip .. "maximized_focus_active_hover.svg"

-- You can use your own layout icons like this:
theme.layout_fairh = layout_icon_path .. "fairh.png"
theme.layout_fairv = layout_icon_path .. "fairv.png"
theme.layout_floating  = layout_icon_path .. "floating.png"
theme.layout_magnifier = layout_icon_path .. "magnifier.png"
theme.layout_max = layout_icon_path .. "max.png"
theme.layout_fullscreen = layout_icon_path .. "fullscreen.png"
theme.layout_tilebottom = layout_icon_path .. "tilebottom.png"
theme.layout_tileleft   = layout_icon_path .. "tileleft.png"
theme.layout_tile = layout_icon_path .. "tile.png"
theme.layout_tiletop = layout_icon_path .. "tiletop.png"
theme.layout_spiral  = layout_icon_path .. "spiral.png"
theme.layout_dwindle = layout_icon_path .. "dwindle.png"
theme.layout_cornernw = layout_icon_path .. "cornernw.png"
theme.layout_cornerne = layout_icon_path .. "cornerne.png"
theme.layout_cornersw = layout_icon_path .. "cornersw.png"
theme.layout_cornerse = layout_icon_path .. "cornerse.png"

-- Recolor layout icons
--theme = theme_assets.recolor_layout(theme, x.color1)

-- Noodle widgets customization --
-- Desktop mode widget variables
-- Symbols ???  ???  ???
-- theme.desktop_mode_color_floating = x.color4
-- theme.desktop_mode_color_tile = x.color3
-- theme.desktop_mode_color_max = x.color1
-- theme.desktop_mode_text_floating = "f"
-- theme.desktop_mode_text_tile = "t"
-- theme.desktop_mode_text_max = "m"

-- Minimal tasklist widget variables
theme.minimal_tasklist_visible_clients_color = x.color4
theme.minimal_tasklist_visible_clients_text = "???"
theme.minimal_tasklist_hidden_clients_color = x.color7
theme.minimal_tasklist_hidden_clients_text = "???"

-- Mpd song
theme.mpd_song_title_color = x.color7
theme.mpd_song_artist_color = x.color7
theme.mpd_song_paused_color = x.color8

-- Volume bar
theme.volume_bar_active_color = x.color6
theme.volume_bar_active_background_color = x.color0
theme.volume_bar_muted_color = x.color8
theme.volume_bar_muted_background_color = x.color0

-- Temperature bar
theme.temperature_bar_active_color = x.color1
theme.temperature_bar_background_color = x.color0

-- Battery bar
theme.battery_bar_active_color = x.color5
theme.battery_bar_background_color = x.color0

-- CPU bar
theme.cpu_bar_active_color = x.color2
theme.cpu_bar_background_color = x.color0

-- RAM bar
theme.ram_bar_active_color = x.color4
theme.ram_bar_background_color = x.color0

-- Brightness bar
theme.brightness_bar_active_color = x.color3
theme.brightness_bar_background_color = x.color0

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Numix"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
