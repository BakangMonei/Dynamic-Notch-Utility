import SwiftUI

class Settings: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var notchOpacity: Double = 0.8
    @Published var enabledModules: Set<String> = []
    @Published var notchPosition: CGPoint = .zero
    @Published var notchSize: CGSize = CGSize(width: 200, height: 30)
    
    // System Settings
        @Published var launchAtLogin = true
        @Published var hideMenuBarIcon = true
        @Published var hideFromScreenCapture = false
    
    // New customization options
    @Published var backgroundColor: Color = .black
    @Published var textColor: Color = .white
    @Published var cornerRadius: Double = 8
    @Published var animationSpeed: Double = 0.3
    @Published var showModuleIcons: Bool = true
    @Published var moduleSpacing: Double = 8
    @Published var autoHide: Bool = false
    @Published var autoHideDelay: Double = 2.0
    @Published var showNotifications: Bool = true
    @Published var notificationDuration: Double = 3.0
    
    // Behavior Settings
        @Published var hapticFeedback = true
        @Published var expandOnHover = true
        @Published var useAccentColor = true
        @Published var naturalMovement = true
        @Published var swipeToToggle = true
    

        @Published var batteryWarningThreshold: Double = 0.2
        @Published var pomodoroWorkDuration: Double = 25
        @Published var pomodoroBreakDuration: Double = 5
        @Published var weatherUpdateInterval: Double = 30
        @Published var clipboardMaxItems = 10
      
    
    
    
    // New battery-specific settings
        @Published var showBatteryPercentage = true
        @Published var lowBatteryWarnings = true
    static let shared = Settings()
    
    private init() {
        // Load saved settings
        loadSettings()
    }
    
    func loadSettings() {
        if let savedSettings = UserDefaults.standard.dictionary(forKey: "appSettings") {
            isDarkMode = savedSettings["isDarkMode"] as? Bool ?? false
            notchOpacity = savedSettings["notchOpacity"] as? Double ?? 0.8
            enabledModules = Set(savedSettings["enabledModules"] as? [String] ?? [])
            
            // Load new settings
            if let bgColorData = savedSettings["backgroundColor"] as? Data,
               let bgColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: bgColorData) {
                backgroundColor = Color(bgColor)
            }
            
            if let textColorData = savedSettings["textColor"] as? Data,
               let textColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: textColorData) {
                self.textColor = Color(textColor)
            }
            
            cornerRadius = savedSettings["cornerRadius"] as? Double ?? 8
            animationSpeed = savedSettings["animationSpeed"] as? Double ?? 0.3
            showModuleIcons = savedSettings["showModuleIcons"] as? Bool ?? true
            moduleSpacing = savedSettings["moduleSpacing"] as? Double ?? 8
            autoHide = savedSettings["autoHide"] as? Bool ?? false
            autoHideDelay = savedSettings["autoHideDelay"] as? Double ?? 2.0
            showNotifications = savedSettings["showNotifications"] as? Bool ?? true
            notificationDuration = savedSettings["notificationDuration"] as? Double ?? 3.0
            
            // Load module-specific settings
            batteryWarningThreshold = savedSettings["batteryWarningThreshold"] as? Double ?? 0.2
            pomodoroWorkDuration = savedSettings["pomodoroWorkDuration"] as? TimeInterval ?? 25 * 60
            pomodoroBreakDuration = savedSettings["pomodoroBreakDuration"] as? TimeInterval ?? 5 * 60
            weatherUpdateInterval = savedSettings["weatherUpdateInterval"] as? TimeInterval ?? 30 * 60
            clipboardMaxItems = savedSettings["clipboardMaxItems"] as? Int ?? 10
        }
    }
    
    func saveSettings() {
        let settings: [String: Any] = [
            "isDarkMode": isDarkMode,
            "notchOpacity": notchOpacity,
            "enabledModules": Array(enabledModules),
            "backgroundColor": try? NSKeyedArchiver.archivedData(withRootObject: NSColor(backgroundColor), requiringSecureCoding: false),
            "textColor": try? NSKeyedArchiver.archivedData(withRootObject: NSColor(textColor), requiringSecureCoding: false),
            "cornerRadius": cornerRadius,
            "animationSpeed": animationSpeed,
            "showModuleIcons": showModuleIcons,
            "moduleSpacing": moduleSpacing,
            "autoHide": autoHide,
            "autoHideDelay": autoHideDelay,
            "showNotifications": showNotifications,
            "notificationDuration": notificationDuration,
            "batteryWarningThreshold": batteryWarningThreshold,
            "pomodoroWorkDuration": pomodoroWorkDuration,
            "pomodoroBreakDuration": pomodoroBreakDuration,
            "weatherUpdateInterval": weatherUpdateInterval,
            "clipboardMaxItems": clipboardMaxItems
        ]
        UserDefaults.standard.set(settings, forKey: "appSettings")
    }
} 
