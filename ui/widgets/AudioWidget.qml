import QtQuick
import qs.core.services
import QtQuick.Layouts
import Quickshell.Widgets
import qs.ui.components
import qs.core

WidgetWrapper {

    Item {
        id: audioWidget
        anchors.centerIn: parent

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight

        RowLayout {
            id: content
            StyledText {
                id: volumeText
                text: Audio.sink?.audio ? Math.round(Audio.sink.audio.volume * 100) + "%" : "N/A"
                font.pointSize: 12
                color: "white"
            }

            IconImage {
                id: audioIcon

                source: Qt.resolvedUrl("../../assets/icons/audio.png")
                Layout.preferredWidth: 16
                Layout.preferredHeight: 16
            }
        }

        // TEMPORARY DEBUG: Toggle dashboard on click

        MouseArea {
            anchors.fill: parent

            onClicked: {
                Context.dashboardWindow.toggle();
            }
        }
    }
}
