"use strict";
// Import
import Gdk from "gi://Gdk";
import App from "resource:///com/github/Aylur/ags/app.js";
// Stuff
import userOptions from "./modules/.configuration/user_options.js";
import {
  firstRunWelcome,
  startBatteryWarningService,
} from "./services/messages.js";
import { startAutoDarkModeService } from "./services/darkmode.js";
// Widgets
import {
  Bar,
  BarCornerTopleft,
  BarCornerTopright,
} from "./modules/bar/main.js";
import Dock from "./modules/dock/main.js";
import Corner from "./modules/screencorners/main.js";
import Indicator from "./modules/indicators/main.js";
import Session from "./modules/session/main.js";
import SideRight from "./modules/sideright/main.js";
import { COMPILED_STYLE_DIR } from "./init.js";

const range = (length, start = 1) =>
  Array.from({ length }, (_, i) => i + start);
function forMonitors(widget) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).map(widget).flat(1);
}
function forMonitorsAsync(widget) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).forEach((i) => widget(i, n).catch(print));
}

// Start stuff
handleStyles(true);
startAutoDarkModeService().catch(print);
firstRunWelcome().catch(print);
startBatteryWarningService().catch(print);

const Windows = () => [
  forMonitors(Indicator),
  SideRight(),
  forMonitors(Session),
  // forMonitors(Dock),
  ...(userOptions.appearance.fakeScreenRounding !== 0
    ? [
        forMonitors((id) => Corner(id, "top left", true)),
        forMonitors((id) => Corner(id, "top right", true)),
        forMonitors((id) => Corner(id, "bottom left", true)),
        forMonitors((id) => Corner(id, "bottom right", true)),
      ]
    : []),
  ...(userOptions.appearance.barRoundCorners
    ? [forMonitors(BarCornerTopleft), forMonitors(BarCornerTopright)]
    : []),
];

const CLOSE_ANIM_TIME = 210; // Longer than actual anim time to make sure widgets animate fully
const closeWindowDelays = {}; // For animations
for (let i = 0; i < (Gdk.Display.get_default()?.get_n_monitors() || 1); i++) {
  closeWindowDelays[`osk${i}`] = CLOSE_ANIM_TIME;
}

App.config({
  css: `${COMPILED_STYLE_DIR}/style.css`,
  stackTraceOnError: true,
  closeWindowDelay: closeWindowDelays,
  windows: Windows().flat(1),
});

// Stuff that don't need to be toggled. And they're async so ugh...
forMonitorsAsync((monitorId, number_of_monitors) =>
  Bar(monitorId, number_of_monitors),
);
// Bar(0).catch(print); // Use this to debug the bar. Single monitor only.
