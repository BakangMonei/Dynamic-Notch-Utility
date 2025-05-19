import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct AboutView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "info.circle")
                .font(.system(size: 48))
                .foregroundColor(.blue)
            
            Text("Dynamic Notch Utility")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Version 1.0.0")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Transform your MacBook's notch into a powerful productivity hub")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
