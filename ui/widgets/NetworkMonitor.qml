import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.ui.components
import qs.core.services

WidgetWrapper {
    id: wrapper

    Item {
        id: root
        implicitHeight: content.implicitHeight
        implicitWidth: content.implicitWidth
        anchors.centerIn: parent

        RowLayout {
            id: content
            spacing: 50

            RowLayout {

                IconImage {
                    source: Qt.resolvedUrl("../../assets/icons/download.png")
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                }
                Item {

                    Layout.preferredWidth: 30
                    StyledText {
                        id: downloadText
                        text: System.download
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.fillWidth: true
                    }
                }
            }

            RowLayout {
                IconImage {
                    source: Qt.resolvedUrl("../../assets/icons/upload.png")
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                }
                Item {
                    Layout.preferredWidth: 75
                    StyledText {
                        text: System.upload
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
