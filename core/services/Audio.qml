pragma Singleton
import QtQuick
import Quickshell.Widgets
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    property var pw: Pipewire

    // Default sink/source for easy access

    readonly property var nodes: Pipewire.nodes.values.reduce((acc, node) => {
        if (!node.isStream) {
            if (node.isSink) {
                acc.sinks.push(node);
            } else if (node.audio) {
                acc.sources.push(node);
            }
        }
        return acc;
    }, {
        sinks: [],
        sources: []
    })

    readonly property list<PwNode> sinks: nodes.sinks
    readonly property list<PwNode> sources: nodes.sources

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool muted: !!sink?.audio?.muted
    readonly property real volume: sink?.audio?.volume ?? 0

    readonly property bool sourceMuted: !!source?.audio?.muted
    readonly property real sourceVolume: source?.audio?.volume ?? 0

    function setVolume(newVolume: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = false;
            sink.audio.volume = Math.max(0, Math.min(1, newVolume));
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
    }

    function setAudioSource(newSource: PwNode): void {
        Pipewire.preferredDefaultAudioSource = newSource;
    }

    onSinkChanged:
    // Some logic here?
    {}

    onSourceChanged:
    // Some logic here?
    {}

    PwObjectTracker {
        id: tracker
        objects: [root.sink, root.source]
    }

    Component.onCompleted: {
        console.log("AudioLogic initialized");
        console.log("Default sink:", root.sink?.name || "None");
        console.log("Default source:", root.source?.name || "None");
        console.log(root.sink.audio.volume);
    }

    // Beat tracker? (CAVA)
}
