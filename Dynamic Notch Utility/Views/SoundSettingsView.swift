import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct SoundSettingsView: View {
    var body: some View {
        VStack {
            Image(systemName: "speaker.wave.3")
                .font(.system(size: 48))
                .foregroundColor(.blue)
            Text("Sound Settings")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Configure audio output and notifications")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
