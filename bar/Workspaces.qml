import QtQuick
import Quickshell.Hyprland

Item {
  Row {
    id: workspacesRow
    spacing: 5
    anchors.verticalCenter: parent.verticalCenter

    Repeater{
      // Create a static model for workspaces 1-5
      model: 5

      Rectangle {
        width: 32
        height: 26
        radius: 8

        // Check if this workspace is active by comparing with current workspace
        property int workspaceId: index + 1
        property bool isActive: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id === workspaceId : false

        color: isActive ? 'darkorange' : '#ebce2b'
        border.color: '#000000'
        border.width: 3

        MouseArea{
          anchors.fill: parent
          onClicked: Hyprland.dispatch("workspace " + workspaceId)
        }

        Text {
          anchors.centerIn: parent
          text: workspaceId
          font.pixelSize: 14
          font.family: "JetBrainsMonoNerdFont-SemiBold"
          font.bold: true
        }
      }
    }
  }
}