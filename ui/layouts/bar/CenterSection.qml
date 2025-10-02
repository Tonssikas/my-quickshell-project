import QtQuick
import qs.ui.widgets
import QtQuick.Layouts

Item {
    id: root
    required property bool isPrimaryScreen

    implicitWidth: centerColumn.implicitWidth
    implicitHeight: centerColumn.implicitHeight

    ColumnLayout {
        id: centerColumn
        anchors.centerIn: parent
        spacing: 2

        Loader {
            Layout.alignment: Qt.AlignHCenter // Centers content in ColumnLayout
            active: true
            sourceComponent: ClockWidget {}
        }
        Loader {
            Layout.alignment: Qt.AlignHCenter // Centers content in ColumnLayout
            active: root.isPrimaryScreen
            sourceComponent: NowPlaying {}
        }
    }
}
