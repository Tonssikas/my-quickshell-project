pragma Singleton
import Quickshell

Singleton {
    // Status bar
    property bool isBarEnabled: true
    property int barHeight: 40
    property int widgetMaxHeight: barHeight - 5

    // WidgetWrapper
    property int widgetBorderRadius: 8
    property int widgetExtraMargin: 16
    property int widgetBorderWidth: 1

    // Notifications
    property int defaultNotificationTimeout: 3000
    property int notificationSaveInterval: 10000
    property string notificationSaveLocation: `${Quickshell.env("HOME")}/.local/state/quickshell/notifs.json`
}