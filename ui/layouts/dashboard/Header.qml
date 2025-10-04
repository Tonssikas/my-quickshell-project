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
    color: '#6e473205'

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    //anchors.topMargin: Screen.height * 0.01
    implicitWidth: headerRow.implicitWidth + extraMargin
    implicitHeight: headerRow.implicitHeight + extraMargin

    RowLayout {
        id: headerRow
        anchors.fill: parent
        spacing: 25

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
