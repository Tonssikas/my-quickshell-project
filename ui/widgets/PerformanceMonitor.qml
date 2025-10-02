import qs.core.services
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell.Widgets
import qs.ui.components

Item {

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    RowLayout {
        id: content

        spacing: 25

        RowLayout {

            IconImage {
                source: Qt.resolvedUrl("../../assets/icons/cpu.png")
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
            }

            ColumnLayout {

                RowLayout {
                    Item {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 15
                        StyledText {
                            text: Math.round(System.cpu_usage) + "%"
                        }
                    }
                    ProgressBar {
                        value: System.cpu_usage / 100
                        Layout.preferredWidth: 75
                        Layout.preferredHeight: 8
                    }
                    IconImage {
                        source: Qt.resolvedUrl("../../assets/icons/meter.png")
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                    }
                }

                RowLayout {
                    Item {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 15
                        StyledText {
                            text: System.cpu_temp >= 0 ? Math.round(System.cpu_temp) + "°C" : "N/A"
                        }
                    }
                    ProgressBar {
                        value: System.gpu_usage >= 0 ? System.gpu_usage / 100 : 0
                        Layout.preferredWidth: 75
                        Layout.preferredHeight: 8
                    }

                    IconImage {
                        source: Qt.resolvedUrl("../../assets/icons/temperature.png")
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                    }
                }
            }
        }

        RowLayout {

            IconImage {
                source: Qt.resolvedUrl("../../assets/icons/gpu.png")
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
            }

            ColumnLayout {

                RowLayout {
                    Item {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 15

                        StyledText {
                            text: Math.round(System.gpu_usage) + "%"
                        }
                    }
                    ProgressBar {
                        value: System.cpu_usage / 100
                        Layout.preferredWidth: 75
                        Layout.preferredHeight: 8
                    }
                    IconImage {
                        source: Qt.resolvedUrl("../../assets/icons/meter.png")
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                    }
                }
                RowLayout {
                    Item {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 15
                        StyledText {
                            text: System.gpu_temp >= 0 ? Math.round(System.gpu_temp) + "°C" : "N/A"
                        }
                    }
                    ProgressBar {
                        value: System.gpu_usage >= 0 ? System.gpu_usage / 100 : 0
                        Layout.preferredWidth: 75
                        Layout.preferredHeight: 8
                    }
                    IconImage {
                        source: Qt.resolvedUrl("../../assets/icons/temperature.png")
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                    }
                }
            }
        }
    }
}
