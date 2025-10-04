pragma Singleton
import QtQuick
import Quickshell

Singleton {

    property var barWindow: null
    property var dashboardWindow: null

    function setBarWindow(window) {
        barWindow = window;
    }

    function setDashboardWindow(window) {
        dashboardWindow = window;
    }
}
