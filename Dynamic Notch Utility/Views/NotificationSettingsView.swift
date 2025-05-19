import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct NotificationSettingsView: View {
    var body: some View {
        VStack {
            Image(systemName: "bell")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("Notification Settings")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Configure notification preferences")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
