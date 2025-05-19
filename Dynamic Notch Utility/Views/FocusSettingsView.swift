import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct FocusSettingsView: View {
    var body: some View {
        VStack {
            Image(systemName: "moon.fill")
                .font(.system(size: 48))
                .foregroundColor(.purple)
            Text("Focus Settings")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Configure Do Not Disturb and Focus modes")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
