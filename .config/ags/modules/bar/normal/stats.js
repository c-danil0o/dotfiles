const { GLib } = imports.gi;
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
const { Box, Button, EventBox, Label, Overlay, Revealer, Scrollable } = Widget;
const { execAsync, exec } = Utils;
import { AnimatedCircProg } from "../../.commonwidgets/cairo_circularprogress.js";
import { MaterialIcon } from '../../.commonwidgets/materialicon.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';


const BarGroup = ({ child }) => Box({
  className: 'bar-group-margin bar-sides',
  children: [
    Box({
      className: 'bar-group bar-group-standalone bar-group-pad-system',
      children: [child],
    }),
  ]
});

const BarBatteryProgress = () => {
  const _updateProgress = (circprog) => { // Set circular progress value
    circprog.css = `font-size: ${Math.abs(Battery.percent)}px;`

    circprog.toggleClassName('bar-batt-circprog-low', Battery.percent <= userOptions.battery.low);
    circprog.toggleClassName('bar-batt-circprog-full', Battery.charged);
  }
  return AnimatedCircProg({
    className: 'bar-batt-circprog',
    vpack: 'center', hpack: 'center',
    extraSetup: (self) => self
      .hook(Battery, _updateProgress)
    ,
  })
}

const BarBattery = () => Box({
  className: 'spacing-h-4 bar-batt-txt',
  children: [
    Revealer({
      transitionDuration: userOptions.animations.durationSmall,
      revealChild: false,
      transition: 'slide_right',
      child: MaterialIcon('bolt', 'norm', { tooltipText: "Charging" }),
      setup: (self) => self.hook(Battery, revealer => {
        self.revealChild = Battery.charging;
      }),
    }),
    Overlay({
      child: Widget.Box({
        vpack: 'center',
        className: 'bar-batt',
        homogeneous: true,
        children: [
          MaterialIcon('battery_full', 'small'),
        ],
        setup: (self) => self.hook(Battery, box => {
          box.toggleClassName('bar-batt-low', Battery.percent <= userOptions.battery.low);
          box.toggleClassName('bar-batt-full', Battery.charged);
        }),
      }),
      overlays: [
        BarBatteryProgress(),
      ]
    }),

    Label({
      className: 'txt-smallie',
      setup: (self) => self.hook(Battery, label => {
        label.label = `${Number.parseFloat(Battery.percent.toFixed(1))}%`;
      }),
    }),
  ]
});

const BarResource = (name, icon, command, circprogClassName = 'bar-batt-circprog', textClassName = 'txt-onSurfaceVariant', iconClassName = 'bar-batt') => {
  const resourceCircProg = AnimatedCircProg({
    className: `${circprogClassName}`,
    vpack: 'center',
    hpack: 'center',
  });
  const resourceProgress = Box({
    homogeneous: true,
    children: [Overlay({
      child: Box({
        vpack: 'center',
        className: `${iconClassName}`,
        homogeneous: true,
        children: [
          MaterialIcon(icon, 'small'),
        ],
      }),
      overlays: [resourceCircProg]
    })]
  });
  const resourceLabel = Label({
    className: `txt-smallie ${textClassName}`,
  });
  const widget = Button({
    onClicked: () => Utils.execAsync(['bash', '-c', `${userOptions.apps.taskManager}`]).catch(print),
    child: Box({
      className: `spacing-h-4 ${textClassName}`,
      children: [
        resourceProgress,
        resourceLabel,
      ],
      setup: (self) => self.poll(5000, () => execAsync(['bash', '-c', command])
        .then((output) => {
          resourceCircProg.css = `font-size: ${Number(output)}px;`;
          resourceLabel.label = `${Math.round(Number(output))}%`;
          widget.tooltipText = `${name}: ${Math.round(Number(output))}%`;
        }).catch(print))
      ,
    })
  });
  return widget;
}

const switchToRelativeWorkspace = async (self, num) => {
  try {
    const Hyprland = (await import('resource:///com/github/Aylur/ags/service/hyprland.js')).default;
    Hyprland.messageAsync(`dispatch workspace ${num > 0 ? '+' : ''}${num}`).catch(print);
  } catch {
    execAsync([`${App.configDir}/scripts/sway/swayToRelativeWs.sh`, `${num}`]).catch(print);
  }
}

export default () => {
  const SystemResources = () => {
    return BarGroup({
      child: Box({
        children: [
          BarResource(getString('RAM Usage'), 'memory', `LANG=C free | awk '/^Mem/ {printf("%.2f\\n", ($3/$2) * 100)}'`,
            'bar-ram-circprog', 'bar-ram-txt', 'bar-ram-icon'),
          Revealer({
            revealChild: true,
            transition: 'slide_left',
            transitionDuration: userOptions.animations.durationLarge,
            child: Box({
              className: 'spacing-h-10 margin-left-10',
              children: [
                BarResource(getString('Swap Usage'), 'swap_horiz', `LANG=C free | awk '/^Swap/ {if ($2 > 0) printf("%.2f\\n", ($3/$2) * 100); else print "0";}'`,
                  'bar-swap-circprog', 'bar-swap-txt', 'bar-swap-icon'),
                BarResource(getString('CPU Usage'), 'settings_motion_mode', `LANG=C top -bn1 | grep Cpu | sed 's/\\,/\\./g' | awk '{print $2}'`,
                  'bar-cpu-circprog', 'bar-cpu-txt', 'bar-cpu-icon'),
              ]
            }),
          }),
        ],
      })
    });
  }

  const BatteryModule = () => {
    return BarGroup({
      child: Box({
        children: [
          BarBattery()
        ],
      })
    });

  }
  return EventBox({
    onScrollUp: (self) => switchToRelativeWorkspace(self, -1),
    onScrollDown: (self) => switchToRelativeWorkspace(self, +1),
    child: Box({
      className: 'spacing-h-4',
      children: [
        SystemResources(),
        BatteryModule(),
      ]
    })
  });
}
