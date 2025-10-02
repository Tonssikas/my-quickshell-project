import QtQuick
import Quickshell
import Quickshell.Services.Notifications

pragma Singleton

Singleton {
    id: root

    // List to store tracked notifications
    property list<QtObject> list: []


    component NotificationWrapper: QtObject {
        id: notif

        property date time: new Date()
        readonly property string timeStr: {
            const now = new Date()
            const diff = now.getTime() - time.getTime()
            const m = Math.floor(diff / 60000)

            if (m < 1)
                return qsTr("now")

            const h = Math.floor(m / 60)
            const d = Math.floor(h / 24)

            if (d > 0)
                return `${d}d`
            if (h > 0)
                return `${h}h`
            return `${m}m`
        }

        // The actual Quickshell notification object
        property var notification
        
        // Wrapper properties
        property string id: notification?.id ?? ""
        property string summary: notification?.summary ?? ""
        property string body: notification?.body ?? ""
        property string appIcon: notification?.appIcon ?? ""
        property string appName: notification?.appName ?? ""
        property string image: notification?.image ?? ""
        property real expireTimeout: notification?.expireTimeout ?? 8000
        property int urgency: notification?.urgency ?? 1
        property bool resident: notification?.resident ?? false
        property bool hasActionIcons: notification?.hasActionIcons ?? false
        property list<var> actions: []
        property bool popup: true // ADDED popup property

        // Expire timer
        readonly property Timer expireTimer: Timer {
            running: notif.popup
            interval: notif.expireTimeout > 0 ? notif.expireTimeout : 8000
            onTriggered: {
                notif.popup = false
            }
        }

        // Connections to sync with the actual notification
        readonly property Connections conn: Connections {
            target: notif.notification

            function onClosed() {
                notif.close()
            }

            function onSummaryChanged() {
                notif.summary = notif.notification.summary
            }

            function onBodyChanged() {
                notif.body = notif.notification.body
            }

            function onAppIconChanged() {
                notif.appIcon = notif.notification.appIcon
            }

            function onAppNameChanged() {
                notif.appName = notif.notification.appName
            }

            function onImageChanged() {
                notif.image = notif.notification.image
            }

            function onExpireTimeoutChanged() {
                notif.expireTimeout = notif.notification.expireTimeout
            }

            function onUrgencyChanged() {
                notif.urgency = notif.notification.urgency
            }

            function onResidentChanged() {
                notif.resident = notif.notification.resident
            }

            function onHasActionIconsChanged() {
                notif.hasActionIcons = notif.notification.hasActionIcons
            }

            function onActionsChanged() {
                notif.actions = notif.notification.actions.map(a => ({
                identifier: a.identifier,
                text: a.text,
                invoke: () => a.invoke()
            }))
            }
        }

        function close() {
            // Remove from root list
            let newList = []
            for (let i = 0; i < root.list.length; i++) {
                if (root.list[i] !== notif) {
                    newList.push(root.list[i])
                }
            }
            root.list = newList
            
            // Dismiss the actual notification
            notification?.dismiss()
            
            // Destroy this wrapper
            notif.destroy()
        }
    }

    NotificationServer {
        id: server

        imageSupported: true
        inlineReplySupported: false
        bodyHyperlinksSupported: true
        keepOnReload: true
        persistenceSupported: true
        actionIconsSupported: false
        bodySupported: true
        bodyMarkupSupported: false
        bodyImagesSupported: false

        onNotification: notif => {
            // Set notification as tracked
            notif.tracked = true

            // Create a wrapper for this notification
            const wrapper = notificationComponent.createObject(root, {
                "notification": notif
            })

            // Add to our list
            root.list.push(wrapper)
        }
    }

    Component {
        id: notificationComponent
        NotificationWrapper {}
    }
}