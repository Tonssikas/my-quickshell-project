import QtQuick
import QtQuick.Controls

Column {
    id: audioMenu

    anchors.fill: parent
    anchors.margins: 8
    spacing: 20

    // Default audio sink
    Column {
        Text {
            text: AudioLogic.defaultAudioSink.description
            color: "darkorange"
        }

        Row {
            spacing: 5

            Slider {
                from: 0
                to: 1
                value: AudioLogic.defaultAudioSink.audio.volume
                onValueChanged: AudioLogic.defaultAudioSink.audio.volume = value
            }

            Text {
                text: Math.round(AudioLogic.defaultAudioSink.audio.volume * 100)
                color: "white"
            }

        }

    }

    // Default audio Source
    Column {
        Text {
            text: AudioLogic.defaultAudioSource.description
            color: "darkorange"
        }

        Row {
            spacing: 5

            Slider {
                from: 0
                to: 1
                value: AudioLogic.defaultAudioSource.audio.volume
                onValueChanged: AudioLogic.defaultAudioSource.audio.volume = value
            }

            Text {
                text: Math.round(AudioLogic.defaultAudioSource.audio.volume * 100)
                color: "white"
            }

        }

    }

}
