import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property string upload: "up"
    property string download: "down"

    Process {
        id: networkproc

        command: ["vnstat", "-tr", "3", "-i", "wlan0", "--json"]
        //command: ["vnstat", "--live", "-i", "wlan0"]
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

    Timer {
        interval: 3000 // Data polling interval
        running: true
        repeat: true
        onTriggered: networkproc.running = true
    }

}
