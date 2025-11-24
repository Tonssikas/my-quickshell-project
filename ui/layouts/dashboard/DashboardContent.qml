import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.ui.layouts

// Main content area for the dashboard

Item {
    // Main layout
    id: layout

    // Layout properties
    anchors.margins: 30

    ColumnLayout {
        id: content
        Layout.fillWidth: true
        anchors.horizontalCenter: parent.horizontalCenter

        /*
        Header {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
        }
        */
        
        TabBar {
            id: bar
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            TabButton {
                text: qsTr("Audio")
            }
            TabButton {
                text: qsTr("Placeholder")
            }
            TabButton {
                text: qsTr("Placeholder")
            }
        }


        StackLayout {
            Layout.alignment: Qt.AlignHCenter

            currentIndex: bar.currentIndex

            Item {
                id: audioTab

                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: layout.width

                    AudioControls {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.fillWidth: true

                    }
                }
            }
            Item {
                id: discoverTab
            }
            Item {
                id: activityTab
            }
        }
    }
    
}
