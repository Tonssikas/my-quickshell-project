import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    property var panelWindow

    width: 28
    height: 28

    Rectangle {
        id: background

        anchors.fill: parent
        color: '#9fdfcbb9'
        radius: 32 // Optional: rounded corners
    }

    IconImage {
        id: audioIcon

        source: Qt.resolvedUrl("./images/audio.png")
        width: 16
        height: 16
        anchors.centerIn: parent

        MouseArea {
            anchors.fill: parent
            onClicked: (event) => {
                if (!audioMenuPopup.isOpen) {
                    const point = mapToGlobal(event.x, event.y);
                    audioMenuPopup.open(point.x, point.y);
                    console.log(audioMenuPopup.isOpen);
                } else {
                    console.log("close");
                    audioMenuPopup.close();
                }
            }
        }

    }

    AudioMenuPopup {
        id: audioMenuPopup

        anchor.window: panelWindow
        implicitWidth: 400
    }

}
