pragma Singleton
import QtQuick
import Quickshell.Widgets
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property var allNodes: Pipewire.nodes?.values ?? []
    readonly property list<PwNode> applications: allNodes.filter(n => n.audio && n.isStream && n.isSink) ?? []
    readonly property list<PwNode> inputs: allNodes.filter(n => n.audio && n.isStream && !n.isSink) ?? []
    readonly property list<PwNode> sinkList: allNodes.filter(n => n.audio && n.properties['media.class'] == "Audio/Sink") ?? []
    readonly property list<PwNode> sourceList: allNodes.filter(n => n.audio && n.properties['media.class'] == "Audio/Source") ?? []

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool muted: !!sink?.audio?.muted
    readonly property real volume: sink?.audio?.volume ?? 0

    readonly property bool sourceMuted: !!source?.audio?.muted
    readonly property real sourceVolume: source?.audio?.volume ?? 0

    function setVolume(newVolume: real, node: PwNode): void {
        if (node.ready && sink.audio) {
            node.audio.muted = false;
            node.audio.volume = Math.max(0, Math.min(1, newVolume));
        }
    }
    function incrementVolume(amount: real): void {
        setVolume(volume + (amount));
    }

    function decrementVolume(amount: real): void {
        setVolume(volume - (amount));
    }

    function setSourceVolume(newVolume: real): void {
        if (source?.ready && source?.audio) {
            source.audio.muted = false;
            source.audio.volume = Math.max(0, Math.min(1, newVolume));
        }
    }

    function setAudioSink(newSink: PwNode): void {
        Pipewire.preferredDefaultAudioSink = newSink;
        console.log("Setting default audio sink to", newSink.description)
    }

    function setAudioSource(newSource: PwNode): void {
        Pipewire.preferredDefaultAudioSource = newSource;
        console.log("Setting default audio source to", newSource.description)
    }

    onSinkChanged:
    // Some logic here?
    {}

    onSourceChanged:
    // Some logic here?
    {}

    PwObjectTracker {
        id: tracker
        objects: [...allNodes]
    }

    Component.onCompleted: {

        
        console.log("AudioLogic initialized");
        console.log("Default sink:", root.sink?.name || "None");
        console.log("Default source:", root.source?.name || "None");
        console.log("allnodes: ", allNodes.length);
        console.log("Audio applications count: ", applications.length);
        console.log("Inputs count: ", inputs.length);
        console.log("Physical sources: ", sourceList.length );
        console.log("Physical sinks: ", sinkList.length)
        console.log(allNodes.forEach(n => console.log(n.name, " ", n.isStream, "", n.isSink)))
        
    }

    // Beat tracker? (CAVA)
}


