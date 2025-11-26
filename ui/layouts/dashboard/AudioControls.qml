import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import qs.ui.components
import qs.themes
import qs.core.services

WidgetWrapper {
    id: audioControls

    topPadding: 10
    bottomPadding: 25
    
    implicitHeight: content.implicitHeight + topPadding + bottomPadding
    implicitWidth: content.implicitWidth + leftPadding + rightPadding

    // Per application output controls
    ColumnLayout {
        id: content
        width: parent.width
        spacing: 30

        StyledText{
            Layout.alignment: Qt.AlignHCenter
            text: "Applications: "
            font.pointSize: 20
        }

        Repeater {

            model: Audio.applications

            delegate: ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.preferredHeight: slider.implicitHeight + text.implicitHeight

                StyledText {
                    id: text
                    Layout.alignment: Qt.AlignHCenter
                    text: modelData.description === "" ? modelData.name : modelData.description
                }

                Slider {
                    id: slider
                    Layout.alignment: Qt.AlignHCenter
                    from: 0
                    to: 100
                    value: modelData.audio.volume * 100

                    onMoved: { Audio.setVolume(Math.floor(value)/100, modelData)}
                }
            }
        
        }

        // Per application input controls

        StyledText{
            Layout.alignment: Qt.AlignHCenter
            text: "Inputs: "
            font.pointSize: 20
        }

        Repeater {

            model: Audio.inputs

            delegate: ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.preferredHeight: slider.implicitHeight + text.implicitHeight

                StyledText {
                    id: text
                    Layout.alignment: Qt.AlignHCenter
                    text: modelData.name
                }

                Slider {
                    id: slider
                    Layout.alignment: Qt.AlignHCenter
                    from: 0
                    to: 100
                    value: modelData.audio.volume * 100

                    onMoved: { Audio.setVolume(Math.floor(value)/100, modelData)}
                }
            }
        
        }

        

        StyledText {
            text: "Default audio devices:"
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 20
        }

            

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true

            ComboBox {
                id: sourceListComboBox
                Layout.alignment: Qt.AlignHCenter
                model: Audio.sourceList
                
                Layout.preferredWidth: Math.max(200, implicitWidth + 40)

                displayText: "Audio source devices"
                //flat: true

                delegate: ItemDelegate {
                    id: delegate
                    
                    
                    width: sourceListComboBox.width

                    required property var model
                    required property int index

                    highlighted: sourceListComboBox.highlightedIndex === index

                    contentItem: Text {
                        text: sourceListComboBox.model[index].description
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                onActivated: {
                    console.log("activated ", highlightedIndex, " ", model[currentIndex].description)
                    Audio.setAudioSource(model[currentIndex])
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter

                StyledText {
                    text: "Default microphone: " + Audio.source.nickname
                }
            }

            Slider {
                Layout.alignment: Qt.AlignHCenter
                from: 0
                to: 100
                value: Audio.source.audio.volume * 100

                onMoved: { Audio.setSourceVolume(Math.floor(value)/100)}
            }

            Item {Layout.preferredHeight: 10}

            ComboBox {
                id: sourceSinkComboBox
                Layout.alignment: Qt.AlignHCenter
                model: Audio.sinkList
                
                Layout.preferredWidth: Math.max(200, implicitWidth + 40)

                displayText: "Audio sink devices"
                //flat: true

                delegate: ItemDelegate {
                    id: delegate
                    
                    
                    width: sourceSinkComboBox.width

                    required property var model
                    required property int index

                    highlighted: sourceSinkComboBox.highlightedIndex === index

                    contentItem: Text {
                        text: sourceSinkComboBox.model[index].nickname || sourceSinkComboBox.model[index].name
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                onActivated: {
                    console.log("activated ", highlightedIndex, " ", model[currentIndex].description)
                    Audio.setAudioSink(model[currentIndex])
                }
            }

            StyledText {
                text: "Default speakers: " + Audio.sink.nickname
            }

            Slider {
                Layout.alignment: Qt.AlignHCenter
                from: 0
                to: 100
                value: Audio.sink.audio.volume * 100

                onMoved: { Audio.setVolume(Math.floor(value)/100, Audio.sink)}
            }
        }

    }
}   