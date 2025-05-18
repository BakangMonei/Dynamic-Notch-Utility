//
//  ContentView.swift
//  Dynamic Notch Utility
//
//  Created by Monei Bakang Mothuti on 19/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var settings = Settings.shared
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Main View
            NotchOverlayView()
                .tabItem {
                    Label("Notch", systemImage: "display")
                }
                .tag(0)
            
            // Settings View
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(1)
            
            // Modules View
            ModulesView()
                .tabItem {
                    Label("Modules", systemImage: "square.grid.2x2")
                }
                .tag(2)
        }
        .frame(width: 400, height: 500)
    }
}

struct SettingsView: View {
    @StateObject private var settings = Settings.shared
    
    var body: some View {
        Form {
            Section("Appearance") {
                ColorPicker("Background Color", selection: $settings.backgroundColor)
                ColorPicker("Text Color", selection: $settings.textColor)
                Slider(value: $settings.notchOpacity, in: 0...1) {
                    Text("Opacity")
                }
                Slider(value: $settings.cornerRadius, in: 0...20) {
                    Text("Corner Radius")
                }
            }
            
            Section("Behavior") {
                Toggle("Auto Hide", isOn: $settings.autoHide)
                if settings.autoHide {
                    Slider(value: $settings.autoHideDelay, in: 1...10) {
                        Text("Hide Delay (seconds)")
                    }
                }
                Toggle("Show Notifications", isOn: $settings.showNotifications)
                Slider(value: $settings.animationSpeed, in: 0.1...1) {
                    Text("Animation Speed")
                }
            }
            
            Section("Module Settings") {
                Slider(value: $settings.batteryWarningThreshold, in: 0.1...0.5) {
                    Text("Battery Warning Threshold")
                }
                Slider(value: $settings.pomodoroWorkDuration, in: 5...60) {
                    Text("Pomodoro Work Duration (minutes)")
                }
                Slider(value: $settings.pomodoroBreakDuration, in: 1...30) {
                    Text("Pomodoro Break Duration (minutes)")
                }
                Slider(value: $settings.weatherUpdateInterval, in: 5...120) {
                    Text("Weather Update Interval (minutes)")
                }
                Stepper("Clipboard History Size: \(settings.clipboardMaxItems)", value: $settings.clipboardMaxItems, in: 5...20)
            }
        }
        .padding()
    }
}

struct ModulesView: View {
    @StateObject private var settings = Settings.shared
    
    private let availableModules = [
        ("battery", "Battery", "battery.100"),
        ("music", "Music", "music.note"),
        ("pomodoro", "Pomodoro", "timer"),
        ("weather", "Weather", "cloud.sun"),
        ("clipboard", "Clipboard", "doc.on.clipboard")
    ]
    
    var body: some View {
        List {
            ForEach(availableModules, id: \.0) { module in
                Toggle(isOn: Binding(
                    get: { settings.enabledModules.contains(module.0) },
                    set: { isEnabled in
                        if isEnabled {
                            settings.enabledModules.insert(module.0)
                        } else {
                            settings.enabledModules.remove(module.0)
                        }
                        settings.saveSettings()
                    }
                )) {
                    HStack {
                        Image(systemName: module.2)
                            .frame(width: 20)
                        Text(module.1)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
