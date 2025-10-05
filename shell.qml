//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.ui.panels
import qs.core.services
import qs.ui.popups

ShellRoot {
    id: root

    Loader {
        active: true
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

    Component.onCompleted: {}
}
