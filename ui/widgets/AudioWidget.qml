import QtQuick
import qs.core.services
import QtQuick.Layouts
import Quickshell.Widgets

Item {
    id: audioWidget

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    RowLayout {
        id: content
        Text {
            id: volumeText
            text: Audio.sink?.audio ? Math.round(Audio.sink.audio.volume * 100) + "%" : "N/A"
            font.pixelSize: 12
            color: "white"
        }

        IconImage {
            id: audioIcon

            source: Qt.resolvedUrl("../../assets/icons/audio.png")
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
        }
    }
}
