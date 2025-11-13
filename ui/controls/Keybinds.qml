pragma Singleton

import QtQuick
import Quickshell
import qs.config
import Quickshell.Hyprland


Item {
    id: root

    property bool enabled: true

    readonly property var shortcuts: ({
        "toggleBar": "Meta+KP_Subtract"
    })

    GlobalShortcut {
        name: "toggle-bar"
        description: "Toggle bar visibility"

        onPressed: {
            General.isBarEnabled = !General.isBarEnabled;
        }
    }
}