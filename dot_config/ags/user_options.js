
const userConfigOptions = {
    // For every option, see ~/.config/ags/modules/.configuration/user_options.js
    // (vscode users ctrl+click this: file://./modules/.configuration/user_options.js)
    // (vim users: `:vsp` to split window, move cursor to this path, press `gf`. `Ctrl-w` twice to switch between)
    //   options listed in this file will override the default ones in the above file
    // Here's an example

    'workspaces': {
        'shown': 6,
    },
    'bar': {
        'modes': ["focus", "normal", "focus"]
    },

    'cheatsheet': {
        'keybinds': {
            'configPath': "~/.config/hypr/custom/keybinds.conf" // Path to hyprland keybind config file. Leave empty for default (~/.config/hypr/hyprland/keybinds.conf)
        }
    },

    'appearance': {
        'fakeScreenRounding': 0, // 0: None | 1: Always | 2: When not fullscreen
        'barRoundCorners': 0, // 0: No, 1: Yes
    },
}

export default userConfigOptions;
