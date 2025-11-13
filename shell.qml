//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.ui.panels
import qs.core.services
import qs.ui.popups
import qs.config
import qs.ui.controls

ShellRoot {
    id: root

    property var keybinds: Keybinds
    property var generalConfig: General

    Loader {
        active: General.isBarEnabled
        sourceComponent: Bar {}
    }

    Loader {
        active: true
        sourceComponent: Dashboard {}
    }

    Loader {
        active: true
        sourceComponent: NotificationPopup {}
    }

    Component.onCompleted: {
         console.log("Keybinds enabled:", Keybinds.enabled);
    }
}
