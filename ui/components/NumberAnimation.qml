import qs.config
import QtQuick

NumberAnimation {
    duration: config.Appearance.anim.durations.normal
    easing.type: Easing.BezierSpline
    easing.bezierCurve: config.Appearance.anim.curves.standard
}
