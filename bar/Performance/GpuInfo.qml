import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.Style as Style
import qs.bar.Performance.GPUdata as GPU

ColumnLayout {
    spacing: 3

    Text {
        id: gpuUsage

        text: "GPU: " + GPU.Usage.value
        color: Style.Default.color
        font.bold: true
    }

    Text {
        id: gpuTemp

        text: "Temp: " + GPU.Temperature.value
        color: Style.Default.color
        font.bold: true
    }

}
