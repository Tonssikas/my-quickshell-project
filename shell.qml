//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.ui.panels

ShellRoot {
    id: root

    Loader {
        active: true
        sourceComponent: Bar {}
    }
}
