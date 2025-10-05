import QtQuick.Layouts
import QtQuick
import qs.ui.widgets

Item {
    id: root
    property bool isPrimaryScreen: false

    implicitWidth: rightRow.implicitWidth
    implicitHeight: rightRow.implicitHeight

    RowLayout {
        id: rightRow
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: PerformanceMonitor {}
            Layout.alignment: Qt.AlignLeft
        }

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: NetworkMonitor {}
        }

        Item {
            Layout.preferredWidth: 650
        }

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: NotificationWidget {}
        }

        Loader {
            active: true
            sourceComponent: SystemTray {}
        }

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: AudioWidget {}
        }

        Loader {
            active: isPrimaryScreen
            sourceComponent: PowerMenuWidget {}
        }
    }
}
