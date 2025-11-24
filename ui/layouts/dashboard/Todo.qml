import qs.core.services
import qs.ui.components
import qs.themes
import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Controls


WrapperRectangle {
    id: root

    property var list: TodoList.todoList
    
    radius: 10
    color: Base.background
    border.width: 1
    border.color: Base.accent
    margin: 25
    topMargin: 15
    bottomMargin: 15

     ColumnLayout {
        id: container
        implicitWidth: root.width - Appearance.padding.large
        implicitHeight: listView.implicitHeight + 100
        spacing: 50


        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            TextField {
                placeholderText: "..."
                horizontalAlignment: TextInput.AlignCenters
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                activeFocusOnPress: true
                onPressed: forceActiveFocus()
            }

            RoundButton {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 200
            }

            
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 10
            spacing: 15
            model: TodoList.todoList
            
            implicitHeight: Math.min(contentHeight, 300)
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            clip: true

            delegate: Rectangle {
                id: listViewItem

                radius: 10
                color: Base.backgroundSecondary
                border.width: 1
                border.color: Base.accent
                anchors.margins: 20
                
                width: container.width - Appearance.padding.large - 35
                height: content.implicitHeight + 30

                RowLayout {
                    id: contentRow
                    anchors.fill: parent
                    anchors.margins: 12

                    StyledText {
                        Layout.alignment: Qt.AlignVCenter
                        id: text
                        text: modelData.name
                    }

                    StyledRectangle {
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                        Layout.minimumWidth: 16
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        radius: 8
                        color: Base.backgroundHover

                        StyledText {
                            anchors.centerIn: parent
                            text: "x"
                            color: Base.textPrimary
                            font.bold: true
                            font.pointSize: 16
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                TodoList.deleteTodoItem(modelData);
                            }
                        }
                    }
                }
            }
        }
    
    }
}