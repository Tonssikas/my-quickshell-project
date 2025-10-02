import QtQuick.Layouts
import QtQuick
import qs.ui.widgets

Item {
    id: root
    required property bool isPrimaryScreen

    implicitWidth: leftColumn.implicitWidth
    implicitHeight: leftColumn.implicitHeight

    RowLayout {
        id: leftColumn
        Layout.alignment: Qt.AlignLeft

        Loader {
            Layout.alignment: Qt.AlignLeft // Aligns to left in RowLayout
            active: true
            sourceComponent: Workspaces {}
        }
    }
}
