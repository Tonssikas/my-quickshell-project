import QtQuick.Controls
import QtQuick
import qs.config

ProgressBar {
    id: progressBar

    Behavior on value {
        NumberAnimation {
            duration: Appearance.anim.durations.large
            easing.type: Easing.InOutQuad
        }
    }
}
