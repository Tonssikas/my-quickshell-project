import QtQuick
import Quickshell.Widgets
import Quickshell

IconImage {
    id: iconButton
    width: 24
    height: 24
    asynchronous: true

    // Custom signal for click handling
    signal clicked

    // Optional: Custom property for button identification
    property string buttonId: ""
    property string tooltipText: ""

    // Mousearea for clicking and tooltip on hover
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            // Emit the custom signal - let parent handle the specific action
            iconButton.clicked();
        }
    }
}
