import Quickshell.Widgets
import QtQuick

WrapperRectangle {
    id: wrapper

    default property alias contentItem: contentContainer.children

    // Configurable styling properties
    property int extraMargin: 16
    property int borderRadius: 12
    property color borderColor: '#85be8130'
    property color backgroundColor: "#85424040"
    property int borderWidth: 1

    implicitWidth: contentContainer.implicitWidth + extraMargin
    implicitHeight: (contentContainer.implicitHeight + extraMargin) < 35 ? (contentContainer.implicitHeight + extraMargin) : 35

    // Apply styling
    radius: borderRadius
    border.width: borderWidth
    border.color: borderColor
    color: backgroundColor

    Item {
        id: contentContainer
        anchors.centerIn: parent
        implicitWidth: children.length > 0 ? children[0].implicitWidth : 0
        implicitHeight: children.length > 0 ? children[0].implicitHeight : 0
    }
}
