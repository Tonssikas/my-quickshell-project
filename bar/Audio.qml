import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Style as Style
import QtQuick.Layouts

Item {
    required property var panelWindow

    implicitWidth: 64
    implicitHeight: 32

    Rectangle {
        id: background

        anchors.fill: parent
        color: '#9fbe7c42'
        radius: 12
    

        RowLayout {
            anchors.fill: parent
            Layout.fillWidth: true

            Style.StyledText {
                id: volumeText
                text: Math.round(AudioLogic.defaultAudioSink.audio.volume * 100) + "%"
                font.pixelSize: 12
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                color: "white"
            }

            IconImage {
                id: audioIcon

                source: Qt.resolvedUrl("./images/audio.png")
                width: 16
                height: 16
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                
            }
        }

        MouseArea {
                    anchors.fill: parent
                    onClicked: event => {
                        if (!audioMenuPopup.isOpen) {
                            const point = mapToGlobal(event.x, event.y);
                            audioMenuPopup.open(point.x, point.y);
                            //console.log(audioMenuPopup.isOpen);
                        } else {
                            //console.log("close");
                            audioMenuPopup.close();
                        }
                    }
                }
    }

    AudioMenuPopup {
        id: audioMenuPopup

        anchor.window: panelWindow
        implicitWidth: 250
        implicitHeight: 125
    }
}
