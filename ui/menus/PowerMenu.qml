import QtQuick.Layouts
import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.ui.components
import qs.themes
import qs.config
import qs.core

PopupWindow {
    id: window
    implicitWidth: 50
    implicitHeight: 275
    visible: false || hideTimer.running
    color: "transparent"

    anchor {
        window: Context.barWindow
        rect.x: screen.width - width
        rect.y: 45
        adjustment: PopupAdjustment.Slide
    }

    property bool isOpen: false

    StyledRectangle {
        anchors.fill: parent
        color: Base.background
        border.color: Base.borderColor
        border.width: 1
        radius: 12

        transform: Translate {
            y: isOpen ? 0 : -window.height

            Behavior on y {
                NumberAnimation {
                    duration: Appearance.anim.durations.extraLarge
                    easing.type: Easing.OutQuart
                }
            }
        }

        ColumnLayout {
            id: layout
            anchors.fill: parent

            IconImage {
                id: powerOff
                source: Qt.resolvedUrl("../../assets/icons/power.png")
                implicitWidth: 32
                implicitHeight: 32
                Layout.alignment: Qt.AlignCenter
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Hyprland.dispatch("exec systemctl poweroff");
                    }
                }
            }

            IconImage {
                id: restart
                source: Qt.resolvedUrl("../../assets/icons/restart.png")
                implicitWidth: 32
                implicitHeight: 32
                Layout.alignment: Qt.AlignCenter
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Hyprland.dispatch("exec systemctl reboot");
                    }
                }
            }

            IconImage {
                id: sleep
                source: Qt.resolvedUrl("../../assets/icons/sleep.png")
                implicitWidth: 32
                implicitHeight: 32
                Layout.alignment: Qt.AlignCenter
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Hyprland.dispatch("exec systemctl suspend");
                    }
                }
            }

            IconImage {
                id: lock
                source: Qt.resolvedUrl("../../assets/icons/lock.png")
                implicitWidth: 32
                implicitHeight: 32
                Layout.alignment: Qt.AlignCenter
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Hyprland.dispatch("exec hyprlock");
                    }
                }
            }

            IconImage {
                id: logout
                source: Qt.resolvedUrl("../../assets/icons/logout.png")
                implicitWidth: 32
                implicitHeight: 32
                Layout.alignment: Qt.AlignCenter
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Hyprland.dispatch("exit");
                    }
                }
            }
        }

        Keys.onEscapePressed: {
            window.isOpen = false;
        }
    }

    Timer {
        id: hideTimer
        interval: Appearance.anim.durations.extraLarge
        running: false
        repeat: false
        onTriggered: {
            window.isOpen = false;
        }
    }

    function toggleMenu() {
        window.isOpen = !window.isOpen;
        if (window.isOpen) {
            window.visible = true;
            hideTimer.stop();
        } else {
            hideTimer.start();
        }
    }
}
