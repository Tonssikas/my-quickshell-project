pragma Singleton
import qs.ui.menus
import QtQuick

QtObject {
    id: root

    property var notificationMenu: notificationMenuComponent.createObject(null)
    property var powerMenu: powerMenuComponent.createObject(null)

    property Component notificationMenuComponent: Component {
        NotificationMenu {}
    }

    property Component powerMenuComponent: Component {
        PowerMenu {}
    }

    function showNotificationMenu() {
        if (!notificationMenu) {
            notificationMenu = notificationMenuComponent.createObject(null);
        }

        notificationMenu.open();
    }

    function hideNotificationMenu() {
        if (notificationMenu) {
            notificationMenu.close();
        }
    }

    function toggleNotificationMenu() {
        if (!notificationMenu) {
            showNotificationMenu();
        } else if (notificationMenu.visible) {
            hideNotificationMenu();
        } else {
            notificationMenu.open();
        }
    }
}
