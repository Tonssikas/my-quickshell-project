import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property string value: "N/A"

    Process {
        id: gpuproc

        command: ["nvidia-smi", "--query-gpu=utilization.gpu"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var rawGpuData = this.text.split("\n");
                if (rawGpuData.length > 1)
                    root.value = rawGpuData[1];
                else
                    value.text = "N/A";
            }
        }

    }

    Timer {
        interval: 3000 // Data polling interval
        running: true
        repeat: true
        onTriggered: gpuproc.running = true
    }

}
