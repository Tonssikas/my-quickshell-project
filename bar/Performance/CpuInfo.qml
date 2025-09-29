import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Style as Style
import qs.bar.Performance.CPUdata as CPU

ColumnLayout {
    spacing: 3

    Text {
        id: cputext

        text: "CPU: " + CPU.Usage.value
        color: Style.Default.color
        font.bold: true
    }

    Text {
        id: cputemp

        text: "Temp: " + CPU.Temperature.value
        color: Style.Default.color
        font.bold: true
    }

}
