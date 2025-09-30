import QtQuick
import Quickshell
import QtQuick.Layouts
import qs.Style as Style
import Quickshell.Widgets
import Quickshell.Hyprland

// ControlCenter window
PanelWindow {
    id: controlCenter

    // Properties that should be passed from parent
    property var targetScreen: Quickshell.screens[0]
    property bool isVisible: false

    exclusiveZone: 0

    visible: isVisible
    screen: targetScreen
    implicitWidth: 500
    implicitHeight: 365
    color: "transparent"
    // Position the Control Center at the top-right corner
    anchors {
        top: true
    }

    WrapperMouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onExited: {
            controlCenter.isVisible = false;
        }

        onClicked: {
            controlCenter.isVisible = !controlCenter.isVisible;
        }

        // Animated content container
        Rectangle {
            id: contentContainer
            anchors.fill: parent
            color: '#75020202'
            bottomLeftRadius: 12
            bottomRightRadius: 12
            border.color: "orange"
            border.width: 1.5

            // Slide animation from top
            transform: Translate {
                y: controlCenter.isVisible ? 0 : -contentContainer.height

                Behavior on y {
                    NumberAnimation {
                        duration: 1250
                        easing.type: Easing.OutBack
                        easing.overshoot: 0
                    }
                }
            }

            // Fade effect
            opacity: controlCenter.isVisible ? 1.0 : 0.0

            Behavior on opacity {
                NumberAnimation {
                    duration: 1250
                    easing.type: Easing.OutQuart
                }
            }

            // Content
            Style.StyledText {
                anchors.centerIn: parent
                text: "placeholder for Control Center"
            }

            //TODO: Media player [Icon, controls, track info]

            // Shutdown, Logout, Restart, Lock screen buttons
            Rectangle {
                id: buttonArea
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 20
                }

                color: '#65c7bba1'
                border.color: Style.Default.color
                border.width: 1.5
                radius: 12

                

                // To fit rectangle to the button layout
                width: buttonRow.width + 16
                height: buttonRow.height + 16

                RowLayout {
                    id: buttonRow
                    anchors.centerIn: parent
                    spacing: 16

                    Style.IconButton {
                        id: lockButton
                        source: Qt.resolvedUrl("./images/lockIcon.svg")
                        onClicked: {
                            Hyprland.dispatch("exec hyprlock");
                        }
                    }
                    Style.IconButton {
                        id: logoutButton
                        source: Qt.resolvedUrl("./images/logout.svg")

                        onClicked: {
                            Hyprland.dispatch("exit");
                        }
                    }
                    Style.IconButton {
                        id: restartButton
                        source: Qt.resolvedUrl("./images/restart.svg")

                        onClicked: {
                            Hyprland.dispatch("exec systemctl reboot");
                        }
                    }
                    Style.IconButton {
                        id: shutdownButton
                        source: Qt.resolvedUrl("./images/shutdown.svg")

                        onClicked: {
                            Hyprland.dispatch("exec systemctl poweroff");
                        }
                    }
                }
            }
        }
    }
}
