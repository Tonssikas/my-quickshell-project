import QtQuick
import qs.ui.widgets

Item {
    id: root

    property bool isPrimaryScreen: false

    Loader {
        active: root.isPrimaryScreen
        anchors.left: parent.left
        anchors.leftMargin: 7
        anchors.verticalCenter: parent.verticalCenter

        sourceComponent: Workspaces {}
    }
}
