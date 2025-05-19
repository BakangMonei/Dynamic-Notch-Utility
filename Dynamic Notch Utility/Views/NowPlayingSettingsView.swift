import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct NowPlayingSettingsView: View {
    var body: some View {
        VStack {
            Image(systemName: "play.fill")
                .font(.system(size: 48))
                .foregroundColor(.pink)
            Text("Now Playing Settings")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Customize music controls and display")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
