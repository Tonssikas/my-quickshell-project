import "./Performance" as Performance
import QtQuick
import QtQuick.Layouts
import Quickshell

RowLayout {
    spacing: 2

    Performance.CpuInfo {
        Layout.preferredWidth: 120
        Layout.alignment: Qt.AlignVCenter
    }

    Performance.GpuInfo {
        Layout.alignment: Qt.AlignVCenter
        Layout.preferredWidth: 120
    }

    Performance.NetworkInfo {
        Layout.preferredWidth: 150
        Layout.alignment: Qt.AlignVCenter
    }

}
