import Quickshell.Widgets
import QtQuick
import qs.config
import qs.themes

WrapperItem {
    id: wrapper

    default property alias contentItem: contentContainer.children

    resizeChild: true

    // Styling properties
    property int extraMargin: General.widgetExtraMargin
    property int borderRadius: General.widgetBorderRadius
    property color borderColor: Base.accent
    property color backgroundColor: Base.background
    property int borderWidth: General.widgetBorderWidth
    
    // Padding inside the wrapper
    property int leftPadding: extraMargin / 2
    property int rightPadding: extraMargin / 2
    property int topPadding: 0
    property int bottomPadding: 0

    implicitWidth: contentContainer.implicitWidth + leftPadding + rightPadding
    implicitHeight: General.widgetMaxHeight

    Rectangle {

    radius: borderRadius
    border.width: borderWidth
    border.color: borderColor
    color: backgroundColor

    Item {
        id: contentContainer

        anchors {
            fill: parent
            leftMargin: wrapper.leftPadding
            rightMargin: wrapper.rightPadding
            topMargin: wrapper.topPadding
            bottomMargin: wrapper.bottomPadding
        }

        implicitWidth: {
            var w = 0
            for (var i = 0; i < children.length; i++) {
                if (children[i].visible) {
                    w = Math.max(w, children[i].implicitWidth)
                }
            }
            return w
        }

        implicitHeight: {
            var h = 0
            for (var i = 0; i < children.length; i++) {
                if (children[i].visible) {
                    h = Math.max(h, children[i].implicitHeight)
                }
            }
            return h
        }
    }}
}