import SwiftUI

struct MainPanelView: View {
    enum SidebarItem: Hashable, CaseIterable, Identifiable {
        case general, battery, connectivity, focus, display, sound, nowPlaying, lockScreen, license, about
        
        var id: Self { self }
        var title: String {
            switch self {
            case .general: return "General"
            case .battery: return "Battery"
            case .connectivity: return "Connectivity"
            case .focus: return "Focus"
            case .display: return "Display"
            case .sound: return "Sound"
            case .nowPlaying: return "Now Playing"
            case .lockScreen: return "Lock Screen"
            case .license: return "License"
            case .about: return "About"
            }
        }
        var icon: String {
            switch self {
            case .general: return "gearshape"
            case .battery: return "bolt.fill"
            case .connectivity: return "dot.radiowaves.left.and.right"
            case .focus: return "moon.fill"
            case .display: return "display"
            case .sound: return "speaker.wave.2.fill"
            case .nowPlaying: return "play.circle.fill"
            case .lockScreen: return "lock.fill"
            case .license: return "checkmark.seal.fill"
            case .about: return "info.circle.fill"
            }
        }
    }
    
    @State private var selection: SidebarItem? = .general
    
    var body: some View {
        NavigationSplitView {
            List(SidebarItem.allCases, selection: $selection) { item in
                Label(item.title, systemImage: item.icon)
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 180)
        } detail: {
            Group {
                switch selection {
                case .general: GeneralSettingsView()
                case .battery: BatterySettingsView()
                case .connectivity: ConnectivitySettingsView()
                case .focus: FocusSettingsView()
                case .display: DisplaySettingsView()
                case .sound: SoundSettingsView()
                case .nowPlaying: NowPlayingSettingsView()
                case .lockScreen: LockScreenSettingsView()
                case .license: LicenseView()
                case .about: AboutView()
                case .none: EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(NSColor.windowBackgroundColor))
        }
        .navigationTitle("Dynamic Notch Utility")
        .frame(minWidth: 700, minHeight: 500)
    }
}

// Placeholder views for each section
struct GeneralSettingsView: View { var body: some View { Text("General Settings") } }
struct BatterySettingsView: View { var body: some View { Text("Battery Settings") } }
struct ConnectivitySettingsView: View { var body: some View { Text("Connectivity Settings") } }
struct FocusSettingsView: View { var body: some View { Text("Focus Settings") } }
struct DisplaySettingsView: View { var body: some View { Text("Display Settings") } }
struct SoundSettingsView: View { var body: some View { Text("Sound Settings") } }
struct NowPlayingSettingsView: View { var body: some View { Text("Now Playing") } }
struct LockScreenSettingsView: View { var body: some View { Text("Lock Screen Settings") } }
struct LicenseView: View { var body: some View { Text("License") } }
struct AboutView: View { var body: some View { Text("About") } }

#Preview {
    MainPanelView()
} 