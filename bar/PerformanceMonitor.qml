import "./Performance" as Performance
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

RowLayout {
   spacing: 50
    
        
    Performance.CpuInfo {
        Layout.preferredWidth: 60
        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
    }


    Performance.GpuInfo {
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        Layout.preferredWidth: 60
    }


    Performance.NetworkInfo {
        Layout.preferredWidth: 60
        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        
    }
}
