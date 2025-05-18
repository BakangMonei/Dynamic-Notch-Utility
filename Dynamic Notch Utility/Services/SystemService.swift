import Foundation
import AppKit

class SystemService: ObservableObject {
    @Published var isFocusModeEnabled: Bool = false
    @Published var brightness: Double = 0.5
    @Published var volume: Double = 0.5
    
    func toggleFocusMode() {
        // Note: This is a placeholder. Actual implementation would require private APIs
        isFocusModeEnabled.toggle()
    }
    
    func setBrightness(_ value: Double) {
        brightness = max(0, min(1, value))
        // Note: Actual implementation would require private APIs
    }
    
    func setVolume(_ value: Double) {
        volume = max(0, min(1, value))
        // Note: Actual implementation would require private APIs
    }
    
    func lockScreen() {
        let task = Process()
        task.launchPath = "/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession"
        task.arguments = ["-suspend"]
        try? task.run()
    }
    
    func toggleDarkMode() {
        let task = Process()
        task.launchPath = "/usr/bin/defaults"
        task.arguments = ["write", "NSGlobalDomain", "AppleInterfaceStyle", "-string", "Dark"]
        try? task.run()
    }
} 