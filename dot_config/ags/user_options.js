
const userConfigOptions = {
  // For every option, see ~/.config/ags/modules/.configuration/user_options.js
  // (vscode users ctrl+click this: file://./modules/.configuration/user_options.js)
  // (vim users: `:vsp` to split window, move cursor to this path, press `gf`. `Ctrl-w` twice to switch between)
  //   options listed in this file will override the default ones in the above file
  // Here's an example

  'workspaces': {
    'shown': 5,
  },
  'bar': {
    'modes': ["focus", "normal", "focus"]
  },


  'appearance': {
    'fakeScreenRounding': 0, // 0: None | 1: Always | 2: When not fullscreen
    'barRoundCorners': 0, // 0: No, 1: Yes
  },

  'dock': {
    'hiddenThickness': 5,
    'pinnedApps': ['zen-beta', 'org.gnome.Nautilus', 'vesktop', 'code', 'kitty'],
    'layer': 'top',
    'monitorExclusivity': true, // Dock will move to other monitor along with focus if enabled
    'searchPinnedAppIcons': false, // Try to search for the correct icon if the app class isn't an icon name
    'trigger': ['client-added'], // client_added, client_move, workspace_active, client_active
    // Automatically hide dock after `interval` ms since trigger
    'autoHide': [
      {
        'trigger': 'client-added',
        'interval': 500,
      },
      {
        'trigger': 'client-removed',
        'interval': 500,
      },
    ],
  },
  // Longer stuff
}

export default userConfigOptions;
