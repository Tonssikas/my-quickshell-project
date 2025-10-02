pragma ComponentBehavior: Bound
import qs.config
import QtQuick

Text {
    id: root

    property bool animate: false
    property string animateProp: "scale"
    property real animateFrom: 0
    property real animateTo: 1
    property int animateDuration: 400

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: "darkorange"
    font.family: "JetBrainsMonoNerdFont-SemiBold"
    font.pointSize: 10

    Behavior on color {
        ColorAnimation {}
    }

    Behavior on text {
        enabled: root.animate

        SequentialAnimation {
            Anim {
                to: root.animateFrom
                //easing.bezierCurve: config.Appearance.anim.curves.standardAccel
                easing.bezierCurve: [0.3, 0, 1, 1, 1, 1]
            }
            PropertyAction {}
            Anim {
                to: root.animateTo
                easing.bezierCurve: [0, 0, 0, 1, 1, 1]
            }
        }
    }

    component Anim: NumberAnimation {
        target: root
        property: root.animateProp
        duration: root.animateDuration / 2
        easing.type: Easing.BezierSpline
    }
}
