import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "gear")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("Select a Setting")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Choose an option from the sidebar")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
