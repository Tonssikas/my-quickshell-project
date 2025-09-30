import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Item {
    implicitHeight: 10

    property list<MprisPlayer> players: Mpris.players.values
    property MprisPlayer active: players.length > 0 ? players[0] : null

    Text {
        id: mediaText
        text: active && active.trackArtist !== "" ? (active.isPlaying ? " ▶ " : " ❚❚ ") + active.trackArtist + " - " + active.trackTitle : ""
        color: "white"
        maximumLineCount: 1
        font.family: "JetBrainsMonoNerdFont-SemiBold"
        font.bold: true
        font.pointSize: 10
    }

    implicitWidth: mediaText.implicitWidth
}
