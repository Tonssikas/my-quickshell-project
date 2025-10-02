import QtQuick

// Centers content both horizontally and vertically
Item {
    id: root

    property alias content: container.children
    property alias spacing: container.spacing
    property bool centerHorizontally: true
    property bool centerVertically: true

    default property alias children: container.data

    Column {
        id: container
        anchors.horizontalCenter: root.centerHorizontally ? parent.horizontalCenter : undefined
        anchors.verticalCenter: root.centerVertically ? parent.verticalCenter : undefined
        x: root.centerHorizontally ? undefined : 0
        y: root.centerVertically ? undefined : 0
    }
}
