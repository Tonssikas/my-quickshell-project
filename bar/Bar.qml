import QtQuick
import QtQuick.Layouts
// Bar.qml
import Quickshell

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData
            readonly property bool isPrimaryScreen: modelData.name === "DP-2"

            screen: modelData
            implicitHeight: 45
            color: '#75020202'

            // Bar alignment
            anchors {
                top: true
                left: true
                right: true
            }

            RowLayout {
                anchors.fill: parent
                Layout.fillWidth: true

                // Left section [WORKSPACES] - primary screen only
                Loader {
                    active: panel.isPrimaryScreen
                    Layout.alignment: Qt.AlignLeft

                    sourceComponent: Workspaces {
                    }

                }

                // Spacer
                Item {
                    Layout.fillWidth: true
                }

                // Center section - Clock on all screens, NowPlaying only on primary
                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 1

                    ClockWidget {
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Loader {
                        active: panel.isPrimaryScreen
                        anchors.horizontalCenter: parent.horizontalCenter

                        sourceComponent: NowPlaying {
                        }

                    }

                }

                // Spacer between center and right
                Item {
                    Layout.fillWidth: true
                }

                // Performance Monitor - primary screen only
                Loader {
                    active: panel.isPrimaryScreen
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

                    sourceComponent: PerformanceMonitor {
                    }

                }

                //TODO adjust spacers
                Item {
                    Layout.preferredWidth: screen.width * 0.25
                }

                // Right section - primary screen only
                Loader {
                    active: panel.isPrimaryScreen

                    sourceComponent: Systray {
                        panelWindow: panel
                    }

                }

                // 20 pixels of space - primary screen only
                Item {
                    Layout.preferredWidth: panel.isPrimaryScreen ? 20 : 0
                }

                Loader {
                    active: panel.isPrimaryScreen
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

                    sourceComponent: Audio {
                        panelWindow: panel
                    }

                }

            }

        }

    }

}
