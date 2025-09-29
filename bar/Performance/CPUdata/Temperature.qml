import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property string value: "N/A"

    Process {
        id: cpuproc

        command: ["sensors", "-j", "-u", "k10temp-pci-00c3"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    let data = JSON.parse(this.text);
                    root.value = data["k10temp-pci-00c3"].Tctl.temp1_input.toFixed(1) + " °C";
                } catch (e) {
                    console.error("Failed to parse CPU temp:", e);
                }
            }
        }

    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: cpuproc.running = true
    }

}
