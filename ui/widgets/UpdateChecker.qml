import QtQuick
import Quickshell
import Quickshell.Io
import qs.core.services
import qs.ui.components
import qs.config

WidgetWrapper {
    id: updateChecker

    Item {
        implicitWidth: text.implicitWidth
        implicitHeight: text.implicitHeight
        
        anchors.centerIn: parent
        StyledText {
            id: text
            text: "Updates available: " + System.updates_available
        }
    }
}