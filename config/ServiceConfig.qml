pragma Singleton
import Quickshell

Singleton {

    // Fast polling interval in milliseconds
    // Used currently for network related stats
    property int fastPollingInterval: 1000

    // Normal polling interval in milliseconds
    // Used currently for CPU and GPU related stats
    property int normalPollingInterval: 2000
}
