import QtQuick 2.15
import qs.ui.components
import qs.config
import qs.core.services
import qs.themes

Item {
    id: clockWidget
    implicitWidth: timeText.implicitWidth
    implicitHeight: timeText.implicitHeight

    StyledText {
        id: timeText
        color: Base.textPrimary
        text: Time.time
        font.bold: true
        font.pointSize: 12
    }
}
