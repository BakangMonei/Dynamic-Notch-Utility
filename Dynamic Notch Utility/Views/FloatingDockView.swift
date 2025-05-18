import SwiftUI

struct FloatingDockView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(20)
            .background(VisualEffectBlur(material: .hudWindow, blendingMode: .withinWindow))
            .cornerRadius(28)
            .shadow(color: Color.black.opacity(0.25), radius: 24, x: 0, y: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .frame(minWidth: 320, minHeight: 120)
    }
}

// VisualEffectBlur for macOS
struct VisualEffectBlur: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }
}

#Preview {
    FloatingDockView {
        VStack {
            Text("Floating Dock Content")
                .foregroundColor(.white)
                .font(.title2.bold())
            Spacer().frame(height: 8)
            HStack {
                Button(action: {}) {
                    Image(systemName: "backward.fill")
                }
                Button(action: {}) {
                    Image(systemName: "play.fill")
                }
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
            }
            .foregroundColor(.white)
            .font(.title2)
        }
        .frame(width: 320, height: 120)
    }
} 