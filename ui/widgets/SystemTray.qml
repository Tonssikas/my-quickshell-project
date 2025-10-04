import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.ui.components
import qs.core

WidgetWrapper {

    RowLayout {
        id: mytray
        spacing: 4
        anchors.centerIn: parent

        Repeater {
            model: SystemTray.items

            delegate: Row {
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
                            // Open menu on rightclick
                            if (event.button == 2) {
                                const point = mapToGlobal(event.x, event.y);

                                if (modelData.hasMenu) {
                                    modelData.display(Context.barWindow, point.x, point.y);
                                }
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
}
