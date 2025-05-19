import SwiftUI
import AppKit
import Foundation
import SwiftUICore


// MARK: - General Settings View
struct GeneralSettingsView: View {
    @StateObject private var settings = Settings.shared
    @State private var showOnMainScreen = true
    @State private var hoverDuration: Double = 0.5
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "gear")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                        Text("General")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    Text("Configure basic settings for your Dynamic Notch")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // System Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("System")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 12) {
                        SettingsRow(
                            title: "Launch at login",
                            icon: "power",
                            iconColor: .green
                        ) {
                            Toggle("", isOn: $settings.launchAtLogin)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                        
                        SettingsRow(
                            title: "Hide menu bar icon",
                            icon: "minus.circle",
                            iconColor: .orange
                        ) {
                            Toggle("", isOn: $settings.hideMenuBarIcon)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                        
                        SettingsRow(
                            title: "Hide from screen capture",
                            icon: "camera.badge.ellipsis",
                            iconColor: .red
                        ) {
                            Toggle("", isOn: $settings.hideFromScreenCapture)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                    }
                    
                    // Display Options
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Display Location")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 16) {
                            DisplayOptionCard(
                                title: "Show on built-in display",
                                icon: "laptopcomputer",
                                isSelected: !showOnMainScreen
                            ) {
                                showOnMainScreen = false
                            }
                            
                            DisplayOptionCard(
                                title: "Show on main screen",
                                icon: "display",
                                isSelected: showOnMainScreen
                            ) {
                                showOnMainScreen = true
                            }
                        }
                    }
                }
                
                // Behavior Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Behaviour")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 12) {
                        SettingsRow(
                            title: "Haptic feedback",
                            subtitle: "Feel subtle vibrations when interacting",
                            icon: "hand.point.up.braille",
                            iconColor: .purple
                        ) {
                            Toggle("", isOn: $settings.hapticFeedback)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                        
                        SettingsRow(
                            title: "Expand notch on hover",
                            subtitle: "Show additional controls when hovering",
                            icon: "cursorarrow.motionlines",
                            iconColor: .blue
                        ) {
                            Toggle("", isOn: $settings.expandOnHover)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                        
                        if settings.expandOnHover {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Hover duration")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("\(hoverDuration, specifier: "%.1f") s")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                
                                Slider(value: $hoverDuration, in: 0.1...2.0, step: 0.1)
                                    .accentColor(.accentColor)
                            }
                            .padding(.leading, 32)
                        }
                    }
                }
                
                // Gestures Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Gestures")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 12) {
                        SettingsRow(
                            title: "Use accent color",
                            subtitle: "Apply system accent color to interface",
                            icon: "paintpalette",
                            iconColor: .pink
                        ) {
                            Toggle("", isOn: $settings.useAccentColor)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                        
                        SettingsRow(
                            title: "Natural movement",
                            subtitle: "Smooth animations that feel responsive",
                            icon: "waveform.path.ecg",
                            iconColor: .green
                        ) {
                            Toggle("", isOn: $settings.naturalMovement)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                        
                        SettingsRow(
                            title: "Swipe to toggle open",
                            subtitle: "Use gestures to expand the notch",
                            icon: "hand.draw",
                            iconColor: .orange
                        ) {
                            Toggle("", isOn: $settings.swipeToToggle)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                    }
                }
                
                Spacer(minLength: 32)
            }
            .padding(24)
        }
        .background(Color(NSColor.controlBackgroundColor))
    }
}


#Preview {
    GeneralSettingsView()
}
