import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.core.services
import qs.ui.components
import qs.themes
import qs.core

PopupWindow {
    id: notificationMenu

    implicitWidth: 400
    implicitHeight: 500
    visible: false
    color: "transparent"

    anchor {
        window: Context.barWindow
        rect.x: screen.width - width - 16
        rect.y: 60
        adjustment: PopupAdjustment.Slide
    }

    StyledRectangle {
        anchors.fill: parent
        color: Base.background
        border.color: Base.borderColor
        border.width: 1
        radius: 12

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            // Header
            StyledText {
                text: `Notifications (${Notifications.list.length})`
                color: Base.textPrimary
                font.bold: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            // ListView for a scollable container
            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                model: Notifications.list
                spacing: 8
                clip: true

                delegate: StyledRectangle {
                    width: ListView.view.width
                    height: 100
                    color: Base.backgroundSecondary
                    border.color: Base.borderLight
                    border.width: 1
                    radius: 8

                    // Main content layout
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 0

                        // Top row - timestamp and close button
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 16

                            Item {
                                Layout.fillWidth: true
                            }

                            StyledText {
                                text: `${modelData.appName || "Unknown"} • ${modelData.timeStr || "now"}`
                                color: Base.textTertiary
                                Layout.alignment: Qt.AlignTop
                                elide: Text.ElideRight
                                Layout.maximumWidth: 150
                            }

                            StyledRectangle {
                                Layout.preferredWidth: 16
                                Layout.preferredHeight: 16
                                radius: 8
                                color: Base.backgroundHover

                                //TODO: Change into an image?
                                StyledText {
                                    anchors.centerIn: parent
                                    text: "X"
                                    color: Base.textPrimary
                                    font.bold: true
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
                            Layout.fillHeight: true
                            spacing: 12

                            // App Icon
                            Image {
                                // Placeholder if appIcon is empty
                                source: modelData.appIcon != "" ? modelData.appIcon : Qt.resolvedUrl("../../assets/icons/notification.png")
                                Layout.preferredHeight: 32
                                Layout.preferredWidth: 32
                            }

                            // ✅ Centered text content
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 4

                                StyledText {
                                    text: modelData.summary || "No title"
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.bold: true
                                    color: Base.textPrimary
                                    elide: Text.ElideRight
                                    wrapMode: Text.WordWrap
                                    maximumLineCount: 1
                                }

                                StyledText {
                                    text: modelData.body || ""
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    color: Base.textSecondary
                                    elide: Text.ElideRight
                                    wrapMode: Text.WordWrap
                                    maximumLineCount: 2
                                }
                            }
                        }
                    }
                }

                // Empty state
                StyledText {
                    text: "No notifications"
                    color: Base.textSecondary
                    Layout.fillWidth: true
                    anchors.centerIn: parent
                    visible: Notifications.list.length === 0
                }
            }
        }
    }

    function toggle() {
        visible = !visible;
    }

    function open() {
        visible = true;
    }

    function close() {
        visible = false;
    }

    onVisibleChanged: {
        if (visible) {
            console.log("Updating notification timestamps");
            Notifications.updateTimestamps();
        }
    }
}
