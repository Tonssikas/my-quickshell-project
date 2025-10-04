import QtQuick
import Quickshell.Hyprland
import qs.ui.components
import qs.themes

WidgetWrapper {

    Item {
        id: root
        implicitWidth: workspacesRow.implicitWidth
        implicitHeight: workspacesRow.implicitHeight
        anchors.centerIn: parent

        Row {
            id: workspacesRow
            spacing: 5
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                // Create a static model for workspaces 1-5
                model: 6

                Rectangle {
                    width: 32
                    height: 26
                    radius: 8

                    // Check if this workspace is active by comparing with current workspace
                    property int workspaceId: index + 1
                    property bool isActive: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id === workspaceId : false

                    color: isActive ? Base.focus : Base.surface2
                    border.color: Base.borderColor
                    border.width: 1

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + workspaceId)
                    }

                    StyledText {
                        anchors.centerIn: parent
                        text: workspaceId
                        font.pixelSize: 14
                        font.family: "JetBrainsMonoNerdFont-SemiBold"
                        font.bold: true
                        color: isActive ? Base.textPrimary : Base.textSecondary
                    }
                }
            }
        }
    }
}
