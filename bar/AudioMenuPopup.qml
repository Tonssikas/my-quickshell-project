// AudioMenuPopup.qml
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick.Controls
import Quickshell.Hyprland

PopupWindow {
    id: audioWindow

    property real posX
    property real posY
    property bool isOpen: false

    anchor.window: parentWindow
    anchor.rect.x: posX
    anchor.rect.y: parentWindow.height

    implicitWidth: 300
    implicitHeight: 400
    visible: false
    color: "transparent"

    Timer {
        id: _hideTimer
        interval: 220
        repeat: false
        onTriggered: audioWindow.visible = false
    }

    Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            id: menu
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height
            radius: 8
            antialiasing: true
            color: Qt.rgba(0, 0, 0, 0.64)
            y: -height
            opacity: 0.0

            // Border settings
            border.color: "darkorange"
            border.width: 2

            // Animation speeds
            Behavior on y {
                NumberAnimation {
                    duration: 450
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }

            // Menu items go here
            AudioMenu {
                anchors.fill: parent
                anchors.margins: 25
            }
        }
    }

    function open(mouseX, mouseY) {
        posX = mouseX - width / 2;
        posY = mouseY + 25;
        isOpen = true;
        audioWindow.visible = true;
        

        // Animate inner menu
        menu.y = -menu.height;
        menu.opacity = 0.0;
        Qt.callLater(function () {
            menu.y = 0;
            menu.opacity = 1.0;
        });
    }

    function close() {
        menu.y = -menu.height;
        menu.opacity = 0.0;
        isOpen = false;
        _hideTimer.start();
    }
}
