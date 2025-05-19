import SwiftUI
import AppKit
import Foundation
import SwiftUICore


struct BatterySettingsView: View {
    @StateObject private var settings = Settings.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "battery.100")
                            .font(.title2)
                            .foregroundColor(.orange)
                        Text("Battery")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    Text("Monitor your battery status and health")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack(spacing: 12) {
                    SettingsRow(
                        title: "Show battery percentage",
                        subtitle: "Display exact percentage in notch",
                        icon: "percent",
                        iconColor: .green
                    ) {
                        Toggle("", isOn: $settings.showBatteryPercentage)
                            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    }
                    
                    SettingsRow(
                        title: "Low battery warnings",
                        subtitle: "Alert when battery runs low",
                        icon: "exclamationmark.triangle",
                        iconColor: .red
                    ) {
                        Toggle("", isOn: $settings.lowBatteryWarnings)
                            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Warning threshold")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("\(Int(settings.batteryWarningThreshold * 100))%")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        
                        Slider(value: $settings.batteryWarningThreshold, in: 0.1...0.5, step: 0.05)
                            .accentColor(.accentColor)
                    }
                    .padding(.leading, 32)
                }
                
                Spacer()
            }
            .padding(24)
        }
        .background(Color(NSColor.controlBackgroundColor))
    }
}

#Preview {
    BatterySettingsView()
}
