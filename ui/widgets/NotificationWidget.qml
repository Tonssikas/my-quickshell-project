import QtQuick.Layouts
import QtQuick
import Quickshell.Widgets
import qs.core.services
import qs.ui.components
import qs.themes
import qs.ui.menus
import Quickshell

WidgetWrapper {
    id: notificationWidget

    implicitWidth: content.implicitWidth + extraMargin
    implicitHeight: content.implicitHeight + extraMargin

    RowLayout {
        id: content
        anchors.fill: parent
        spacing: 0

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                MenuManager.toggleNotificationMenu();
            }
        }

        StyledText {
            text: Notifications.list.length > 0 ? Notifications.list.length : ""
            visible: Notifications.list.length > 0
            font.pointSize: 12
            font.bold: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.leftMargin: 5
        }

        IconImage {
            source: Qt.resolvedUrl("../../assets/icons/notification.png")
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
    }
}
