import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Style as Style
import qs.bar.Performance.Networkdata as Network

ColumnLayout {
    spacing: 3

    Text {
        id: download

        text: "↓ " + Network.Data.download
        color: Style.Default.color
        font.bold: true
    }

    Text {
        id: upload

        text: "↑ " + Network.Data.upload
        color: Style.Default.color
        font.bold: true
    }

}
