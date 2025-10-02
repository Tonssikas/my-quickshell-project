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
        spacing: 15

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: PerformanceMonitor {}
        }

        Item {
            Layout.preferredWidth: 750
        }

        Loader {
            active: true
            sourceComponent: SystemTray {}
        }

        Loader {
            active: root.isPrimaryScreen
            sourceComponent: AudioWidget {}
        }
    }
}
