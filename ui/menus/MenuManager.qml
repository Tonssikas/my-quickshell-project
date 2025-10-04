pragma Singleton
import QtQuick
import qs.ui.menus

QtObject {
    id: root

    property var notificationMenu: null

    property Component notificationMenuComponent: Component {
        NotificationMenu {}
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
