import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.ui.widgets
import qs.ui.components
import qs.ui.layouts.bar

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

            Item {
                anchors.fill: parent
                anchors.margins: 8

                // Left section - anchored to left
                LeftSection {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    isPrimaryScreen: panel.isPrimaryScreen
                }

                // Center section - anchored to center
                CenterSection {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    isPrimaryScreen: panel.isPrimaryScreen
                }

                // Right section - anchored to right
                RightSection {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    isPrimaryScreen: panel.isPrimaryScreen
                }
            }
        }
    }
}
