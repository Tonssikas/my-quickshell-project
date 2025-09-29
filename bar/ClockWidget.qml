// ClockWidget.qml
import QtQuick
import qs.Style as Style

Text {
    color: Style.Default.color
    // directly access the time property from the Time singleton
    text: Time.time
    font.family: Style.Default.fontFamily
    font.bold: true
    font.pointSize: 10
}
