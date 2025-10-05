import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.ui.components
import qs.ui.menus

WidgetWrapper {
    id: wrapper

    IconImage {
        id: content
        source: Qt.resolvedUrl("../../assets/icons/power.png")
        implicitWidth: 24
        implicitHeight: 24
        anchors.centerIn: parent

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.OpenHandCursor
            onClicked: {
                MenuManager.powerMenu.toggleMenu();
            }
        }
    }
}
