pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Pipewire

Singleton {
    id: logic

    property var pw: Pipewire

    // Expose sinks/sources so other components can bind
    property var defaultAudioSink: pw.defaultAudioSink
    property var defaultAudioSource: pw.defaultAudioSource
    

    PwObjectTracker {
        id: tracker
        objects: [logic.defaultAudioSource, logic.defaultAudioSink]
    }


property list<var> audioApps: []


    PwObjectTracker {
        id: audioAppTracker

    }


    

    function getAudioApps() {
        //console.log("Pwlength: ", Pipewire.nodes.rowCount())
        // Use rowcount to figure amount of nodes

        for (let i = 0; i < Pipewire.nodes.rowCount(); i++) {

            audioAppTracker.objects.push(pw.nodes.values[i])
            //console.log(audioAppTracker.objects)

            for (let node of audioAppTracker.objects) {
                let props = node.properties
            }


            console.log(JSON.stringify(pw.nodes.values[i].properties))

            if (pw.nodes.values[i].isStream){
                
            }
            
        }
        
        /*
        for (var prop in Pipewire.nodes) {
        console.log("Property:", prop, "=", Pipewire.nodes[prop])
        }
        */
        //console.log("Audio apps:", audioApps)
    }

    
}



