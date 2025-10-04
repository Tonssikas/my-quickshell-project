import QtQuick
import QtQuick.Layouts
import qs.ui.layouts

// Main content area for the dashboard

Item {

    // Main layout

    id: layout

    // Layout properties
    property int minItemWidth: 150
    property int maxItemWidth: 300
    property bool equalWidth: true
    anchors.margins: 20

    // Example items (replace with actual dashboard widgets)
    Header {}
}
