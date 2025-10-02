import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Item {
    id: player
    implicitWidth: mediaText.implicitWidth
    implicitHeight: mediaText.implicitHeight

    property list<MprisPlayer> players: Mpris.players.values
    property MprisPlayer active: players.length > 0 ? players[0] : null

    Text {
        id: mediaText
        text: player.active && player.active.trackArtist !== "" ? (player.active.isPlaying ? " ▶ " : " ❚❚ ") + player.active.trackArtist + " - " + player.active.trackTitle : ""
        color: "white"
        maximumLineCount: 1
        font.family: "JetBrainsMonoNerdFont-SemiBold"
        font.bold: true
        font.pointSize: 10
    }
}
