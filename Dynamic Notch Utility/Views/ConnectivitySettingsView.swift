import SwiftUI
import AppKit
import Foundation
import SwiftUICore
struct ConnectivitySettingsView: View {
    var body: some View {
        VStack {
            Image(systemName: "wifi")
                .font(.system(size: 48))
                .foregroundColor(.green)
            Text("Connectivity Settings")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Manage WiFi and network preferences")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ConnectivitySettingsView()
}
