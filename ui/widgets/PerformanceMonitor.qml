import qs.core.services
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import Quickshell.Widgets

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

                ProgressBar {
                    value: System.cpu_usage / 100
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 8
                }

                ProgressBar {
                    value: System.gpu_usage >= 0 ? System.gpu_usage / 100 : 0
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 8
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

                ProgressBar {
                    value: System.cpu_usage / 100
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 8
                }

                ProgressBar {
                    value: System.gpu_usage >= 0 ? System.gpu_usage / 100 : 0
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 8
                }
            }
        }
    }
}
