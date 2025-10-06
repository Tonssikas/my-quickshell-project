import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.ui.components
import qs.core.services

WidgetWrapper {
    id: wrapper

    Item {
        id: root
        implicitHeight: content.implicitHeight
        implicitWidth: content.implicitWidth
        anchors.centerIn: parent

        RowLayout {
            id: content
            anchors.fill: parent
            anchors.centerIn: parent

            IconImage {
                source: Qt.resolvedUrl("../../assets/icons/ram.png")
                Layout.preferredWidth: 24
                Layout.preferredHeight: 24
                Layout.alignment: Qt.AlignCenter
            }

            StyledText {
                text: System.ram_usage + " / " + System.ram_total
            }
        }
    }
}
