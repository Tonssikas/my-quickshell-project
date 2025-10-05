import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets
import qs.ui.components
import qs.themes
import qs.core.services
import qs.core
import qs.config

PopupWindow {
    id: root

    implicitWidth: 400
    implicitHeight: content.implicitHeight
    visible: popupNotifications.length > 0
    color: "transparent"

    anchor {
        window: Context.barWindow
        rect.x: screen.width - width - 16
        rect.y: 60
        adjustment: PopupAdjustment.Slide
    }

    property var popupNotifications: Notifications.list.filter(n => n.popup)

    ColumnLayout {
        id: content
        width: parent.width
        anchors.margins: 12
        spacing: 12

        Repeater {
            model: root.popupNotifications

            delegate: StyledRectangle {
                required property var modelData

                Layout.fillWidth: true
                Layout.preferredHeight: notifContent.implicitHeight + 24
                Layout.minimumHeight: 60

                color: Base.backgroundSecondary
                border.color: Base.borderLight
                border.width: 1
                radius: 8

                // Main content layout
                ColumnLayout {
                    id: notifContent
                    width: parent.width - 24
                    anchors.centerIn: parent
                    spacing: 4

                    // Top row - timestamp and close button
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Item {
                            Layout.fillWidth: true
                        }

                        StyledText {
                            id: timestampText
                            text: `${modelData.appName || "Unknown"} • ${modelData.timeStr || "now"}`
                            color: Base.textTertiary
                            font.pointSize: 11
                            elide: Text.ElideMiddle
                            Layout.alignment: Qt.AlignTop | Qt.AlignRight
                            Layout.maximumWidth: parent.width - 32
                        }

                        StyledRectangle {
                            Layout.preferredWidth: 16
                            Layout.preferredHeight: 16
                            Layout.minimumWidth: 16
                            radius: 8
                            color: Base.backgroundHover

                            StyledText {
                                anchors.centerIn: parent
                                text: "×"
                                color: Base.textPrimary
                                font.bold: true
                                font.pointSize: 12
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    modelData.close();
                                }
                            }
                        }
                    }

                    // Center content row - icon and text
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        // App Icon
                        Image {
                            source: modelData.appIcon != "" ? modelData.appIcon : Qt.resolvedUrl("../../assets/icons/notification.png")
                            Layout.preferredHeight: 32
                            Layout.preferredWidth: 32
                            Layout.alignment: Qt.AlignTop
                        }
                        // Text content
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            StyledText {
                                text: modelData.summary || "No title"
                                Layout.fillWidth: true
                                font.bold: true
                                color: Base.textPrimary
                                wrapMode: Text.WordWrap
                            }

                            StyledText {
                                text: modelData.body || ""
                                Layout.fillWidth: true
                                color: Base.textSecondary
                                wrapMode: Text.WordWrap
                                visible: text !== ""
                            }
                        }
                    }
                }
            }
        }
    }
}
