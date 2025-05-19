import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct FloatingDockView<Content: View>: View {
    let content: Content
    @State private var isHovering = false
    @State private var isSettingsPresented = false
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Main floating dock content
            HStack {
                content
                
                Spacer()
                
                // Settings button
                Button(action: {
                    isSettingsPresented = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                        .frame(width: 32, height: 32)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        // Add subtle hover effect for settings button
                    }
                }
            }
            .padding(20)
            .background(VisualEffectBlur(material: .hudWindow, blendingMode: .withinWindow))
            .cornerRadius(28)
            .shadow(color: Color.black.opacity(0.25), radius: 24, x: 0, y: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .frame(minWidth: 380, minHeight: 120)
            .onHover { hovering in
                withAnimation(.easeInOut(duration: 0.3)) {
                    isHovering = hovering
                }
            }
            
            // Expanded content on hover
            if isHovering {
                VStack(spacing: 16) {
                    MusicModule()
                    WeatherModule()
                    SystemStatsModule()
                }
                .padding(20)
                .background(VisualEffectBlur(material: .hudWindow, blendingMode: .withinWindow))
                .cornerRadius(28)
                .shadow(color: Color.black.opacity(0.25), radius: 24, x: 0, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
                .frame(width: 420)
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.95).combined(with: .opacity).combined(with: .move(edge: .top)),
                    removal: .scale(scale: 0.95).combined(with: .opacity).combined(with: .move(edge: .top))
                ))
                .zIndex(1)
                .offset(y: -200)
            }
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsWindow()
        }
    }
}

// Settings Window wrapper
struct SettingsWindow: View {
    var body: some View {
        ContentView()
            .frame(width: 900, height: 600)
    }
}

// System Stats Module for expanded view
struct SystemStatsModule: View {
    var body: some View {
        HStack(spacing: 20) {
            // CPU Usage
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 3)
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .trim(from: 0, to: 0.35)
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(-90))
                    
                    Text("35%")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("CPU")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            // Memory Usage
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 3)
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .trim(from: 0, to: 0.6)
                        .stroke(Color.orange, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(-90))
                    
                    Text("60%")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("Memory")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            // Battery
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 3)
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .trim(from: 0, to: 0.85)
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(-90))
                    
                    Text("85%")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("Battery")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            // Network
            VStack(spacing: 8) {
                Image(systemName: "wifi")
                    .font(.title2)
                    .foregroundColor(.green)
                    .frame(width: 40, height: 40)
                
                Text("WiFi")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding(16)
        .background(Color.black.opacity(0.3))
        .cornerRadius(16)
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
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                // Album artwork placeholder
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(
                        colors: [Color.orange, Color.pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: "music.note")
                            .foregroundColor(.white)
                            .font(.title3)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Yahweh Sabaoth")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Text("Ogoh Precious")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(1)
                }
                
                Spacer()
            }
            
            // Control buttons
            HStack(spacing: 16) {
                Button(action: {}) {
                    Image(systemName: "backward.fill")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {}) {
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
}
