import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Row {
    id: mytray
    spacing: 4

    property var panelWindow

    Repeater {
        model: SystemTray.items

        delegate: Row {
            /*
      Text {
        color:"darkorange"
        text:SystemTray.items.values[index].title
      }
      */

            IconImage {
                visible: true
                source: modelData.icon

                width: 20
                height: 20

                MouseArea {
                    id: mouseArea
                    acceptedButtons: {
                        Qt.LeftButton | Qt.RightButton;
                    }
                    anchors.fill: parent
                    //onClicked: console.log("Click!"+ model.index)

                    onClicked: event => {
                        // 2 Stands for rightclick
                        if (event.button == 2) {
                            const point = mapToGlobal(event.x, event.y);

                            //console.log("Has menu")
                            //console.log("icon index: " , index)
                            //console.log("mouse x:", event.x, " mouse y:", event.y)
                            //console.log(point)
                            modelData.display(panelWindow, point.x, panelWindow.height);
                        } else if (event.button == 1) {
                            console.log("activate");
                            modelData.activate();
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("Systemtray debug:" + SystemTray.items.values[1].icon);
        console.log("Menu handle: " + SystemTray.items.values[1].menu);
        console.log("Menu: " + SystemTray.items.values[1]);
    }
}
