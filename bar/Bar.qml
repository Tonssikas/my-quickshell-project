import QtQuick
import QtQuick.Layouts
// Bar.qml
import Quickshell
import Quickshell.Widgets

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData
            readonly property bool isPrimaryScreen: modelData.name === "DP-2"

            screen: modelData
            implicitHeight: 50
            color: '#00000000'

            // Bar alignment
            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                radius: 8
                

                RowLayout {
                    anchors.fill: parent
                    Layout.fillWidth: true

                    // 20 pixels of space - primary screen only
                    Item {
                        Layout.preferredWidth: panel.isPrimaryScreen ? 20 : 0
                    }

                    // Left section [WORKSPACES] - primary screen only
                    Loader {
                        active: panel.isPrimaryScreen
                        Layout.alignment: Qt.AlignLeft

                        sourceComponent: Workspaces {}
                    }

                    // Spacer
                    Item {
                        Layout.fillWidth: true
                    }

                    // Center section - Clock on all screens, NowPlaying only on primary

                    Column {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 1

                        ClockWidget {
                            anchors.horizontalCenter: parent.horizontalCenter

                            // Mouse area for activating Control Center
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    controlCenter.isVisible = true;
                                }
                            }
                        }

                        ControlCenter {
                            id: controlCenter
                            targetScreen: panel.modelData
                            isVisible: false
                        }

                        Loader {
                            active: panel.isPrimaryScreen
                            anchors.horizontalCenter: parent.horizontalCenter

                            sourceComponent: NowPlaying {}
                        }
                    }

                    

                    // Performance Monitor - primary screen only
                    Loader {
                        active: panel.isPrimaryScreen
                        Layout.alignment: Qt.AlignVCenter

                        sourceComponent: PerformanceMonitor {}
                    }

                    //TODO adjust spacers
                    Item {
                        Layout.preferredWidth: screen.width * 0.09
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

                    Item {
                        Layout.preferredWidth: panel.isPrimaryScreen ? 10 : 0
                    }
                }
            }
        }
    }
}
