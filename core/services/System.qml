pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Singleton {
    id: root

    property real cpu_usage: 0
    property real cpu_temp: 0

    property real gpu_usage: 0
    property real gpu_temp: 0

    property string upload: "N/A"
    property string download: "N/A"

    property string ram_usage: "N/A"
    property string ram_total: "N/A"
    property string ram_available: "N/A"

    Timer {
        id: normalTimer
        interval: ServiceConfig.normalPollingInterval
        running: false
        repeat: true

        onTriggered: {
            // Trigger processes to update data
            cpuUsage.running = true;
            temperatureProcess.running = true;
            gpuUsage.running = true;
            ramUsage.running = true;
        }
    }

    Timer {
        id: fastTimer
        interval: ServiceConfig.fastPollingInterval
        running: false
        repeat: true

        onTriggered:
        // Trigger processes to update data
        {
            networkproc.running = true;
        }
    }

    // CPU usage
    Process {
        id: cpuUsage

        property int prevTotal: 0
        property int prevBusy: 0

        command: ["cat", "/proc/stat"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                // Parse CPU usage data
                let lines = this.text.trim().split("\n");
                let cpuLine = lines[0].trim().split(/\s+/);
                let user = +cpuLine[1];
                let nice = +cpuLine[2];
                let system = +cpuLine[3];
                let idle = +cpuLine[4];
                let iowait = +cpuLine[5];
                let irq = +cpuLine[6];
                let softirq = +cpuLine[7];

                let total = user + nice + system + idle + iowait + irq + softirq;
                let busy = total - idle - iowait;
                if (cpuUsage.prevTotal !== undefined && cpuUsage.prevBusy !== undefined) {
                    let totalDiff = total - cpuUsage.prevTotal;
                    let busyDiff = busy - cpuUsage.prevBusy;
                    let usagePercent = (busyDiff / totalDiff) * 100;
                    root.cpu_usage = usagePercent.toFixed(2);
                }

                cpuUsage.prevTotal = total;
                cpuUsage.prevBusy = busy;
            }
        }
    }

    // GPU usage

    Process {
        id: gpuUsage

        command: ["nvidia-smi", "--query-gpu=utilization.gpu"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var rawGpuData = this.text.split("\n");
                if (rawGpuData.length > 1) {
                    root.gpu_usage = parseFloat(rawGpuData[1]).toFixed(2) || 0;
                } else {
                    root.gpu_usage = -1;
                }
            }
        }
    }

    // Network monitoring

    Process {
        id: networkproc

        command: ["vnstat", "-tr", "3", "-i", "wlan0", "--json"]
        running: true

        stdout: StdioCollector {
            id: stdoutCollector

            onStreamFinished: {
                try {
                    // Parse the JSON text
                    var data = JSON.parse(this.text);
                    // Access RX and TX rates
                    root.download = data.rx.ratestring;
                    root.upload = data.tx.ratestring;
                } catch (e) {
                    console.error("Failed to parse vnstat JSON:", e);
                }
            }
        }
    }

    // Temperature Process
    Process {
        id: temperatureProcess
        command: ["sh", "-c", "cpu_temp=$(sensors 2>/dev/null | sensors -j -u k10temp-pci-00c3 | jq '.[\"k10temp-pci-00c3\"].Tctl.temp1_input'); " + "gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1); " + "if [ -z \"$gpu_temp\" ]; then gpu_temp=$(sensors 2>/dev/null | grep -E 'edge|junction' | head -1 | grep -oE '[0-9]+\\.[0-9]+' | head -1); fi; " + "echo \"${cpu_temp:-0} ${gpu_temp:-0}\""]

        stdout: StdioCollector {
            onStreamFinished: {
                const parts = this.text.trim().split(/\s+/);
                if (parts.length >= 2) {
                    root.cpu_temp = parseFloat(parts[0]).toFixed(0) || 0;
                    root.gpu_temp = parseFloat(parts[1]).toFixed(0) || 0;
                }
            }
        }
    }

    // RAM usage

    Process {
        id: ramUsage
        running: true

        command: ["sh", "-c", "free -h | grep Mem"]

        stdout: StdioCollector {
            onStreamFinished: {
                const parts = this.text.trim().split(/\s+/);
                if (parts.length >= 7) {
                    root.ram_total = parts[1];
                    root.ram_usage = parts[2];
                    root.ram_available = parts[6];
                }
            }
        }
    }

    // Public API functions
    function startMonitoring() {
        fastTimer.start();
        normalTimer.start();
    }
    function stopMonitoring() {
        fastTimer.stop();
        normalTimer.stop();
    }

    Component.onCompleted: {
        startMonitoring();
    }
}
