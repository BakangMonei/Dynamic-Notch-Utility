import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct LicenseView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.seal")
                .font(.system(size: 48))
                .foregroundColor(.green)
            Text("License")
                .font(.title2)
                .fontWeight(.semibold)
            Text("View licensing information")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
