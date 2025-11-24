import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


// Main content area for the dashboard

Item {
    // Main layout
    id: layout

    // Layout properties
    

    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 30

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
                text: qsTr("Todo List")
            }
            TabButton {
                text: qsTr("Placeholder")
            }
        }


        StackLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true

            currentIndex: bar.currentIndex

            Item {
                id: audioTab
                AudioControls {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width

                }
            }
            Item {
                id: todoList
                
                Todo {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                }   
            }
            Item {
                id: activityTab
            }
        }
    }
    
}
