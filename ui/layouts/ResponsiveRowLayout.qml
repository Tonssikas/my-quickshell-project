import QtQuick
import QtQuick.Layouts

// Row that adapts to available space
RowLayout {
    id: root

    property int minItemWidth: 100
    property int maxItemWidth: 200
    property int itemSpacing: 8
    property bool equalWidth: false

    spacing: itemSpacing

    // Automatically adjusts item widths based on available space
    onWidthChanged: {
        if (equalWidth && children.length > 0) {
            const availableWidth = width - (children.length - 1) * spacing;
            const itemWidth = Math.max(minItemWidth, Math.min(maxItemWidth, availableWidth / children.length));

            for (let i = 0; i < children.length; i++) {
                if (children[i].Layout) {
                    children[i].Layout.preferredWidth = itemWidth;
                }
            }
        }
    }
}
