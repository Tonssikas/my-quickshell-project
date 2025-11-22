import QtQuick.Layouts
import QtQuick
import qs.ui.widgets
import qs.core.services

Item {
    id: root
    property bool isPrimaryScreen: false

    implicitWidth: rightRow.implicitWidth
    implicitHeight: rightRow.implicitHeight

    RowLayout {
        id: rightRow
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: PerformanceMonitor {}
            Layout.alignment: Qt.AlignVCenter
        }

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: RamWidget {}
            Layout.alignment: Qt.AlignVCenter
        }

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: NetworkMonitor {}
            Layout.alignment: Qt.AlignVCenter
        }

        Item {
            Layout.preferredWidth: 10
        }

        Loader {
            active: root.isPrimaryScreen && System.updates_available > 0
            sourceComponent: UpdateChecker {}
            Layout.alignment: Qt.AlignVCenter
        }
        Loader {
            active: root.isPrimaryScreen
            sourceComponent: NotificationWidget {}
            Layout.alignment: Qt.AlignVCenter
        }

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: SystemTray {}
            Layout.alignment: Qt.AlignVCenter
        }

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: AudioWidget {}
            Layout.alignment: Qt.AlignVCenter
        }

        Loader {
            active: isPrimaryScreen
            sourceComponent: PowerMenuWidget {}
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
