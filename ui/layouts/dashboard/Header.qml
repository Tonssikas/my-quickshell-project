import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell.Widgets
import qs.ui.components
import qs.themes

WidgetWrapper {
    id: headerWrapper

    border.width: 3
    border.color: Base.background
    color: Base.backgroundSecondary

    implicitWidth: headerRow.implicitWidth + extraMargin
    implicitHeight: headerRow.implicitHeight + extraMargin

    RowLayout {
        id: headerRow
        anchors.fill: parent
        spacing: 25
        Layout.margins: 4

        IconImage {
            source: Qt.resolvedUrl("../../../assets/icons/placeholder.svg")
            Layout.preferredWidth: 64
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignVCenter
        }

        IconImage {
            source: Qt.resolvedUrl("../../../assets/icons/placeholder.svg")
            Layout.preferredWidth: 64
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignVCenter
        }

        IconImage {
            source: Qt.resolvedUrl("../../../assets/icons/placeholder.svg")
            Layout.preferredWidth: 64
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignVCenter
        }

        IconImage {
            source: Qt.resolvedUrl("../../../assets/icons/placeholder.svg")
            Layout.preferredWidth: 64
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
