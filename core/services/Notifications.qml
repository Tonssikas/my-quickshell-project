pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import qs.config

Singleton {
    id: root

    property list<QtObject> list: []
    property int count: list.length
    property bool loaded: false

    // Global trigger to update all timestamps at once
    property int timestampUpdateTrigger: 0

    component NotificationWrapper: QtObject {
        id: notif

        property date time: new Date()

        readonly property string timeStr: {
            // Force dependency on global trigger
            root.timestampUpdateTrigger;

            const now = new Date();
            const diff = now.getTime() - time.getTime();
            const m = Math.floor(diff / 60000);

            if (m < 1)
                return "Just now";
            if (m < 60)
                return m + " min";

            const h = Math.floor(m / 60);
            if (h < 24)
                return h + " hr";
            const d = Math.floor(h / 24);
            return d + " d";
        }

        function toJson() {
            return {
                time: time.getTime(),
                summary: summary,
                body: body,
                appIcon: appIcon,
                appName: appName,
                image: image,
                urgency: urgency,
                id: id
            };
        }

        property var notification

        // Wrapper properties
        property string id: notification?.id ?? ""
        property string summary: notification?.summary ?? ""
        property string body: notification?.body ?? ""
        property string appIcon: notification?.appIcon ?? ""
        property string appName: notification?.appName ?? ""
        property string image: notification?.image ?? ""
        property real expireTimeout: {
            const t = notification?.expireTimeout;
            return (typeof t === "number" && t >= 0) ? t : General.defaultNotificationTimeout;
        }
        property int urgency: notification?.urgency ?? 1
        property bool resident: notification?.resident ?? false
        property bool hasActionIcons: notification?.hasActionIcons ?? false
        property list<var> actions: []
        property bool popup: true
        property bool isDestroying: false

        readonly property Timer expireTimer: Timer {
            running: notif.popup && notif.expireTimeout > 0 && !notif.isDestroying
            interval: notif.expireTimeout > 0 ? notif.expireTimeout : General.defaultNotificationTimeout
            onTriggered: {
                notif.popup = false;
                
                if (!notif.resident && !notif.isDestroying) {
                    notif.close();
                }
                
            }
        }

        readonly property Connections conn: Connections {
            target: notif.notification ?? null
            enabled: notif.notification !== null && !notif.isDestroying

            
            function onClosed() {
                if (!notif.isDestroying) {
                    root.removeNotification(notif);
                }
            }

            function onSummaryChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.summary = notif.notification.summary;
                }
            }

            function onBodyChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.body = notif.notification.body;
                }
            }

            function onAppIconChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.appIcon = notif.notification.appIcon;
                }
            }

            function onAppNameChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.appName = notif.notification.appName;
                }
            }

            function onImageChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.image = notif.notification.image;
                }
            }

            function onExpireTimeoutChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.expireTimeout = notif.notification.expireTimeout;
                }
            }

            function onUrgencyChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.urgency = notif.notification.urgency;
                }
            }

            function onResidentChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.resident = notif.notification.resident;
                }
            }

            function onHasActionIconsChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.hasActionIcons = notif.notification.hasActionIcons;
                }
            }

            function onActionsChanged() {
                if (notif.notification && !notif.isDestroying) {
                    notif.actions = notif.notification.actions.map(a => ({
                        identifier: a.identifier,
                        text: a.text,
                        invoke: () => a.invoke()
                    }));
                }
            }
        }

        function cleanup() {
            isDestroying = true;
            expireTimer.stop();
            conn.enabled = false;
            notification = null;
        }

        function dismiss() {
            if (!isDestroying && notification && typeof notification.dismiss === 'function') {
                notification.dismiss();
            }
            root.removeNotification(notif);
        }

        function close() {
            if (!isDestroying && notification && typeof notification.expire === 'function') {
                notification.expire();
            }
            root.removeNotification(notif);
        }
    }

    NotificationServer {
        id: server

        imageSupported: true
        inlineReplySupported: false
        bodyHyperlinksSupported: true
        keepOnReload: false
        persistenceSupported: true
        actionIconsSupported: false
        bodySupported: true
        bodyMarkupSupported: false
        bodyImagesSupported: true

        Component.onCompleted: {
            console.log("NotificationServer created successfully");
        }

        onNotification: notif => {
            console.log("New notification received:", notif.summary);

            notif.tracked = true;

            const wrapper = notificationComponent.createObject(root, {
                "notification": notif,
                "time": new Date()
            });

            if (!wrapper) {
                console.error("Failed to create notification wrapper");
                return;
            }

            const newList = [wrapper, ...root.list];
            if (newList.length > 100) {
                const removed = newList.slice(100);
                removed.forEach(item => {
                    item.cleanup();
                    item.destroy();
                });
                root.list = newList.slice(0, 100);
            } else {
                root.list = newList;
            }

            saveTimer.restart();

            console.log("Notification added, total count:", root.list.length);
        }
    }

    // Save timer for writing to disk
    Timer {
        id: saveTimer
        interval: General.notificationSaveInterval
        repeat: false
        onTriggered: root.save()
    }

    FileView {
        id: storage

        path: General.notificationSaveLocation
        onLoaded: {
            try {
                const textContent = text();
                if (!textContent || !textContent.trim()) {
                    console.log("Empty notifications file");
                    root.loaded = true;
                    return;
                }

                const data = JSON.parse(textContent);
                console.log("Loading", data.length, "notifications from storage");

                if (root.list.length > 0) {
                    root.list.forEach(wrapper => {
                        if (wrapper && typeof wrapper.cleanup === 'function') {
                            wrapper.cleanup();
                            wrapper.destroy();
                        }
                    });
                }
                root.list = [];

                const loadedWrappers = [];

                for (const notifData of data) {
                    const wrapper = notificationComponent.createObject(root, {
                        "time": new Date(notifData.time),
                        "popup": false
                    });

                    if (wrapper) {
                        wrapper.summary = notifData.summary || "";
                        wrapper.body = notifData.body || "";
                        wrapper.appIcon = notifData.appIcon || "";
                        wrapper.appName = notifData.appName || "";
                        wrapper.image = notifData.image || "";
                        wrapper.urgency = notifData.urgency || 1;
                        wrapper.id = notifData.id || "";

                        loadedWrappers.push(wrapper);
                    }
                }

                loadedWrappers.sort((a, b) => b.time.getTime() - a.time.getTime());
                root.list = loadedWrappers;
            } catch (error) {
                console.error("Failed to parse notifications:", error);
                setText("[]");
                root.list = [];
            }

            root.loaded = true;
            console.log("Loaded", root.list.length, "unique notifications");
        }

        onLoadFailed: err => {
            console.log("Load failed:", err);
            if (err === FileViewError.FileNotFound) {
                console.log("No notifications file found, creating empty one");
                setText("[]");
            }
            root.loaded = true;
        }
    }

    Component {
        id: notificationComponent
        NotificationWrapper {}
    }

    function save() {
        if (!loaded)
            return;

        try {
            const data = root.list.slice(0, 100).filter(wrapper => wrapper && wrapper.summary).map(wrapper => wrapper.toJson());

            const jsonString = JSON.stringify(data, null, 2);
            storage.setText(jsonString);

            console.log("Saved", data.length, "notifications to storage");
        } catch (error) {
            console.error("Failed to save notifications:", error);
        }
    }

    function removeNotification(wrapper) {
        if (!wrapper)
            return;

        const index = root.list.indexOf(wrapper);
        if (index === -1)
            return;

        console.log("Removing notification:", wrapper.summary);

        root.list = root.list.filter(item => item !== wrapper);

        wrapper.cleanup();
        wrapper.destroy();

        root.save();

        console.log("Notification removed, remaining count:", root.list.length);
    }

    function clearAll() {
        console.log("Clearing all notifications");

        root.list.forEach(wrapper => {
            if (wrapper) {
                if (wrapper.notification && typeof wrapper.notification.dismiss === 'function') {
                    wrapper.notification.dismiss();
                }
                wrapper.cleanup();
                wrapper.destroy();
            }
        });

        root.list = [];
        root.save();

        console.log("All notifications cleared");
    }

    function updateTimestamps() {
        console.log("Updating notification timestamps");
        root.timestampUpdateTrigger++; // Increment to trigger updates
    }

    Component.onDestruction: {
        saveTimer.stop();
        save();
        clearAll();
    }
}
