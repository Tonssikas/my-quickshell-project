import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property string value: "N/A"

    function calculateUsagePercentage() {
        if (!cpudata.rawCpuData)
            return ;

        let current = cpudata.rawCpuData.split("\n")[0].trim().split(/\s+/);
        let idle = +current[4] + +current[5]; // idle + iowait
        let total = current.slice(1).reduce((sum, val) => {
            return sum + (+val);
        }, 0); // sum numeric fields
        if (cpudata.prev_total === undefined) {
            cpudata.prev_total = total;
            cpudata.prev_idle = idle;
            return ;
        }
        let diff_idle = idle - cpudata.prev_idle;
        let diff_total = total - cpudata.prev_total;
        let usage = ((diff_total - diff_idle) / diff_total) * 100;
        //console.log(usage.toFixed(2))
        root.value = usage.toFixed(2) + " %";
        cpudata.prev_total = total;
        cpudata.prev_idle = idle;
    }

    Item {
        id: cpudata

        property var rawCpuData
        property var prev_total
        property var prev_idle

        Process {
            id: cpuproc

            // split into program and arguments
            command: ["cat", "/proc/stat"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: cpudata.rawCpuData = this.text.trim()
            }

        }

        Timer {
            interval: 3000 // Data polling interval
            running: true
            repeat: true
            onTriggered: cpuproc.running = true
        }

        Connections {
            //console.log(cpudata.rawCpuData)

            target: cpudata
            onRawCpuDataChanged: {
                calculateUsagePercentage();
            }
        }

    }

}
