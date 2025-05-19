import SwiftUI
import AppKit
import Foundation
import SwiftUICore

// MARK: - Main Content View
struct ContentView: View {
    @StateObject private var settings = Settings.shared
    @State private var selectedTab: Int? = 0
    
    var body: some View {
        NavigationView {
            // Sidebar
            List {
                NavigationLink(
                    destination: GeneralSettingsView(),
                    tag: 0,
                    selection: $selectedTab
                ) {
                    Label("General", systemImage: "gear")
                        .foregroundColor(.primary)
                }
                
                Section("Notifications") {
                    NavigationLink(
                        destination: NotificationSettingsView(),
                        tag: 1,
                        selection: $selectedTab
                    ) {
                        Label("Notifications", systemImage: "bell")
                            .foregroundColor(.primary)
                    }
                }
                
                Section("Module Settings") {
                    NavigationLink(
                        destination: BatterySettingsView(),
                        tag: 2,
                        selection: $selectedTab
                    ) {
                        Label("Battery", systemImage: "battery.100")
                            .foregroundColor(.orange)
                    }
                    
                    NavigationLink(
                        destination: ConnectivitySettingsView(),
                        tag: 3,
                        selection: $selectedTab
                    ) {
                        Label("Connectivity", systemImage: "wifi")
                            .foregroundColor(.green)
                    }
                    
                    NavigationLink(
                        destination: FocusSettingsView(),
                        tag: 4,
                        selection: $selectedTab
                    ) {
                        Label("Focus", systemImage: "moon.fill")
                            .foregroundColor(.purple)
                    }
                    
                    NavigationLink(
                        destination: DisplaySettingsView(),
                        tag: 5,
                        selection: $selectedTab
                    ) {
                        Label("Display", systemImage: "display")
                            .foregroundColor(.purple)
                    }
                    
                    NavigationLink(
                        destination: SoundSettingsView(),
                        tag: 6,
                        selection: $selectedTab
                    ) {
                        Label("Sound", systemImage: "speaker.wave.3")
                            .foregroundColor(.blue)
                    }
                }
                
                Section("Live Activities") {
                    NavigationLink(
                        destination: NowPlayingSettingsView(),
                        tag: 7,
                        selection: $selectedTab
                    ) {
                        Label("Now Playing", systemImage: "play.fill")
                            .foregroundColor(.pink)
                    }
                    
                    NavigationLink(
                        destination: LockScreenSettingsView(),
                        tag: 8,
                        selection: $selectedTab
                    ) {
                        Label("Lock Screen", systemImage: "lock.fill")
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Alcove") {
                    NavigationLink(
                        destination: LicenseView(),
                        tag: 9,
                        selection: $selectedTab
                    ) {
                        Label("License", systemImage: "checkmark.seal")
                            .foregroundColor(.green)
                    }
                    
                    NavigationLink(
                        destination: AboutView(),
                        tag: 10,
                        selection: $selectedTab
                    ) {
                        Label("About", systemImage: "info.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 250)
            
            // Main content area
            Group {
                if selectedTab == 0 {
                    GeneralSettingsView()
                } else {
                    EmptyStateView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 900, height: 600)
        .onAppear {
            selectedTab = 0
        }
    }
}


#Preview {
    ContentView()
}
