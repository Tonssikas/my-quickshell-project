import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.ui.widgets
import qs.ui.components
import qs.ui.layouts.bar
import qs.config
import qs.core

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData
            readonly property bool isPrimaryScreen: modelData.name === "DP-2"

            screen: modelData
            implicitHeight: General.barHeight
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

    RowLayout {
        id: barRow
        anchors.fill: parent
        spacing: 12

        LeftSection {
            Layout.alignment: Qt.AlignLeft || Qt.AlignVCenter
            Layout.fillHeight: true
            isPrimaryScreen: panel.isPrimaryScreen
        }



        CenterSection {
            anchors.centerIn: parent
            Layout.fillHeight: true
            isPrimaryScreen: panel.isPrimaryScreen
        }



        RightSection {
            Layout.alignment: Qt.AlignRight || Qt.AlignVCenter
            Layout.fillHeight: true
            isPrimaryScreen: panel.isPrimaryScreen
        }
    }
}


            Component.onCompleted: {
                // Register this bar window if the primary screen in Context for global access
                if (panel.isPrimaryScreen) {
                    Context.setBarWindow(panel);
                }
            }
        }
    }
}
