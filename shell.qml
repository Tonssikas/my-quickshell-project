//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.ui.panels
import qs.core.services

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

    Component.onCompleted: {}
}
