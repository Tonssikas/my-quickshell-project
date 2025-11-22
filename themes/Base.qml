pragma Singleton
import QtQuick 2.15
import Quickshell

Singleton {
    // ✅ Background colors
    property color background: "#85424040"
    property color backgroundSecondary: "#99000000"  // 60% opacity black (darker)
    property color backgroundTertiary: "#66000000"   // 40% opacity black (lighter)
    property color backgroundCard: "#B3000000"       // 70% opacity black (cards/panels)
    property color backgroundHover: "#4D000000"      // 30% opacity black (hover states)

    // ✅ Primary orange variations
    property color primary: "#FF8C00"             // Dark orange
    property color primaryLight: "#FFB347"        // Light orange
    property color primaryDark: "#CC7000"         // Darker orange
    property color primaryFaded: "#4DFF8C00"      // 30% opacity orange

    // ✅ Accent colors
    property color accent: "#FFA040"              // Slightly lighter orange
    property color accentSecondary: "#FF6B35"     // Red-orange accent
    property color accentTertiary: "#FFD700"      // Golden yellow accent

    // ✅ Text colors
    property color textPrimary: '#fca82b'         // Dark orange
    property color textSecondary: "#B0B0B0"       // Light gray
    property color textTertiary: "#808080"        // Medium gray
    property color textDisabled: "#4D4D4D"        // Dark gray (disabled)
    property color textInverse: "#000000"         // Black (for light backgrounds)

    // ✅ Border colors
    property color borderColor: '#85be8130'       // Your existing border
    property color borderLight: '#4DFFFFFF'       // Light border (30% white)
    property color borderDark: '#80000000'        // Dark border (50% black)
    property color borderAccent: '#80FF8C00'      // Orange border (50% opacity)

    // ✅ Status colors
    property color success: "#28A745"             // Green
    property color successLight: "#6CBB6B"        // Light green
    property color warning: "#FFC107"             // Yellow
    property color warningLight: "#FFE066"        // Light yellow
    property color error: "#DC3545"               // Red
    property color errorLight: "#F5A9A9"          // Light red
    property color info: "#17A2B8"                // Blue
    property color infoLight: "#7DD3FC"           // Light blue

    // ✅ Interactive states
    property color hover: "#4DFFFFFF"             // 30% white overlay
    property color pressed: "#66000000"           // 40% black overlay
    property color selected: "#80FF8C00"          // 50% orange overlay
    property color focus: "#BFFF8C00"             // 75% orange outline

    // ✅ Surface colors (for layered UI)
    property color surface1: "#1A000000"          // 10% black (subtle elevation)
    property color surface2: "#33000000"          // 20% black (cards)
    property color surface3: "#4D000000"          // 30% black (modals)
    property color surface4: "#66000000"          // 40% black (dropdowns)

    // ✅ Semantic colors for UI elements
    property color separator: "#33FFFFFF"         // 20% white separator lines
    property color placeholder: "#66B0B0B0"       // Faded text placeholder
    property color shadow: "#80000000"            // Drop shadow color
    property color overlay: "#B3000000"           // Modal overlay background
}
