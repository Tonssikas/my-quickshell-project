import QtQuick.Controls
import QtQuick

ProgressBar {
    id: progressBar

    Behavior on value {
        NumberAnimation {
            duration: 800
            easing.type: Easing.InOutQuad
        }
    }
}
