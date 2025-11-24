import qs.core.services
import qs.ui.components
import qs.themes
import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets


WrapperRectangle {
    id: root

    property var list: TodoList.todoList
    
    radius: 10
    color: Base.background
    border.width: 1
    border.color: Base.accent
    margin: 25
    topMargin: 30
    bottomMargin: 30

     Item {
        id: container
        implicitWidth: root.width - Appearance.padding.large
        implicitHeight: listView.implicitHeight + 100

    

        ListView {
            id: listView
            anchors.fill: parent
            spacing: 15
            model: TodoList.todoList
            anchors.margins: 20 
            implicitHeight: Math.min(contentHeight, 200)
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds

            delegate: WrapperRectangle {
                id: listViewItem

                radius: 10
                color: Base.backgroundSecondary
                border.width: 1
                border.color: Base.accent
                topMargin: 15
                bottomMargin: 15

                width: container.width - Appearance.padding.large
                anchors.horizontalCenter: parent.horizontalCenter

                RowLayout {
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