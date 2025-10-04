import QtQuick
import Quickshell
import qs.core
import Quickshell.Widgets
import qs.ui.components
import qs.themes
import qs.config
import qs.ui.layouts.dashboard
import qs.ui.layouts

PopupWindow {
    id: dashboard

    property var parentWindow: Context.barWindow
    property bool isOpen: false

    implicitHeight: screen.height * 0.9
    implicitWidth: 500
    visible: false
    color: "transparent"

    anchor {
        window: parentWindow
        rect.x: screen.width - width
        rect.y: screen.height * 0.05
        adjustment: PopupAdjustment.None
    }

    WrapperMouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onExited: {
            dashboard.close();
        }

        onClicked: {
            dashboard.close();
        }

        Item {
            anchors.fill: parent

            StyledRectangle {
                color: Base.background
                width: parent.width
                height: parent.height
                radius: 12
                border.color: Base.borderColor
                border.width: 3

                x: isOpen ? 0 : width

                Behavior on x {
                    NumberAnimation {
                        duration: Appearance.anim.durations.extraLarge
                        easing.type: Easing.OutQuart
                    }
                }

                // Content
                DashboardContent {
                    anchors.fill: parent
                }
            }
        }
    }
    // Timer to add delay before hiding the dashboard so the closing animation can play
    Timer {
        id: hideTimer
        interval: Appearance.anim.durations.extraLarge
        onTriggered: dashboard.visible = false
    }

    function toggle() {
        if (!isOpen) {
            // Opening
            visible = true;
            isOpen = true;
            hideTimer.stop();
        } else {
            // Closing
            isOpen = false;
            hideTimer.start();
        }
    }

    function close() {
        if (isOpen) {
            isOpen = false;
            hideTimer.start();
        }
    }

    function open() {
        if (!isOpen) {
            visible = true;
            isOpen = true;
            hideTimer.stop();
        }
    }

    Component.onCompleted: {
        Context.setDashboardWindow(dashboard);
    }
}
