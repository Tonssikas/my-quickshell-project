pragma Singleton
import Quickshell

Singleton {

    // Fast polling interval in milliseconds
    // Used currently for network related stats
    property int fastPollingInterval: 1000

    // Normal polling interval in milliseconds
    // Used currently for CPU and GPU related stats
    property int normalPollingInterval: 2000

    // Very slow interval is 15 minutes
    // Used currently for yay updates polling
    property int verySlowPollingInterval: 1800000
}
