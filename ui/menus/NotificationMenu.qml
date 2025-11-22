import QtQuick.Layouts
import QtQuick
import Quickshell
import qs.core.services
import qs.ui.components
import qs.themes
import qs.core
import qs.config

PopupWindow {
    id: notificationMenu

    property bool isOpen: false

    implicitWidth: 400
    implicitHeight: 700
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

        transform: Translate {
            y: isOpen ? 0 : -notificationMenu.height

            Behavior on y {
                NumberAnimation {
                    duration: Appearance.anim.durations.extraLarge
                    easing.type: Easing.OutQuart
                }
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            RowLayout {
                id: headerRow
                Layout.fillWidth: true

                // Header
                StyledText {
                    text: `Notifications (${Notifications.list.length})`
                    color: Base.textPrimary
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }

                StyledText {
                    text: "Clear All"
                    color: Base.textPrimary
                    font.bold: true
                    font.underline: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignRight
                    Layout.leftMargin: -45
                    visible: Notifications.list.length > 0

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Notifications.clearAll();
                        }
                    }
                }
            }

            // ListView for a scrollable container
            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                model: Notifications.list
                spacing: 8
                clip: true

                delegate: StyledRectangle {
                    width: ListView.view.width
                    height: notifContent.implicitHeight + 24
                    implicitHeight: height
                    property int minHeight: 60
                    property int maxHeight: 200

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
                                    font.pointSize: 16
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        modelData.dismiss();
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

                            // Text content - adaptive to content length
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

                                // Content image (if any)
                                Image {
                                    source: modelData.image || ""
                                    Layout.fillWidth: true
                                    fillMode: Image.PreserveAspectFit

                                    visible: source !== ""
                                }
                            }
                        }
                    }
                }

                // Empty state
                StyledText {
                    text: "No notifications"
                    color: Base.textSecondary
                    anchors.centerIn: parent
                    visible: Notifications.list.length === 0
                }
            }
        }
    }

    Timer {
        id: hideTimer
        interval: Appearance.anim.durations.extraLarge
        running: false

        onTriggered: {
            notificationMenu.visible = false;
        }
    }

    function toggle() {
        if (!isOpen) {
            // Opening
            open();
        } else {
            // Closing
            close();
        }
    }

    function close() {
        if (isOpen) {
            isOpen = false;
            hideTimer.start();
        }
    }

    function open() {
        if (!isOpen) {
            visible = true;
            isOpen = true;
            hideTimer.stop();
        }
    }

    onVisibleChanged: {
        if (visible) {
            Notifications.updateTimestamps();
        }
    }
}
