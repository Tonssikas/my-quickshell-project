import qs.core.services
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell.Widgets
import qs.ui.components

WidgetWrapper {

    Item {
        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight
        anchors.centerIn: parent

        RowLayout {
            id: content
            spacing: 15

            RowLayout {
                IconImage {
                    source: Qt.resolvedUrl("../../assets/icons/cpu.png")
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                }

                ColumnLayout {

                    RowLayout {
                        Item {
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 10
                            StyledText {
                                text: Math.round(System.cpu_usage) + "%"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        AnimatedProgressBar {
                            value: System.cpu_usage / 100
                            Layout.preferredWidth: 75
                            Layout.preferredHeight: 6
                        }
                        IconImage {
                            source: Qt.resolvedUrl("../../assets/icons/meter.png")
                            Layout.preferredWidth: 12
                            Layout.preferredHeight: 12
                        }
                    }

                    RowLayout {
                        Item {
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 10
                            StyledText {
                                text: System.cpu_temp >= 0 ? Math.round(System.cpu_temp) + "°C" : "N/A"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        AnimatedProgressBar {
                            value: System.cpu_temp >= 0 ? System.cpu_temp / 100 : 0
                            Layout.preferredWidth: 75
                            Layout.preferredHeight: 6
                        }

                        IconImage {
                            source: Qt.resolvedUrl("../../assets/icons/temperature.png")
                            Layout.preferredWidth: 12
                            Layout.preferredHeight: 12
                        }
                    }
                }
            }

            RowLayout {

                IconImage {
                    source: Qt.resolvedUrl("../../assets/icons/gpu.png")
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                }

                ColumnLayout {

                    RowLayout {
                        Item {
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 10

                            StyledText {
                                text: Math.round(System.gpu_usage) + "%"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        AnimatedProgressBar {
                            value: System.gpu_usage / 100
                            Layout.preferredWidth: 75
                            Layout.preferredHeight: 6
                        }
                        IconImage {
                            source: Qt.resolvedUrl("../../assets/icons/meter.png")
                            Layout.preferredWidth: 12
                            Layout.preferredHeight: 12
                        }
                    }
                    RowLayout {
                        Item {
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 10
                            StyledText {
                                text: System.gpu_temp >= 0 ? Math.round(System.gpu_temp) + "°C" : "N/A"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        AnimatedProgressBar {
                            value: System.gpu_temp >= 0 ? System.gpu_temp / 100 : 0
                            Layout.preferredWidth: 75
                            Layout.preferredHeight: 6
                        }
                        IconImage {
                            source: Qt.resolvedUrl("../../assets/icons/temperature.png")
                            Layout.preferredWidth: 12
                            Layout.preferredHeight: 12
                        }
                    }
                }
            }
        }
    }
}
