import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct NotchOverlayView: View {
    @StateObject private var settings = Settings.shared
    @State private var currentModuleIndex = 0
    @State private var isVisible = true
    
    private let modules: [any Module] = [
        BaseModule(id: "battery", name: "Battery", icon: "battery.100", view: BatteryModule()),
        BaseModule(id: "music", name: "Music", icon: "music.note", view: MusicModule()),
        BaseModule(id: "pomodoro", name: "Pomodoro", icon: "timer", view: PomodoroModule()),
        BaseModule(id: "weather", name: "Weather", icon: "cloud.sun", view: WeatherModule()),
        BaseModule(id: "clipboard", name: "Clipboard", icon: "doc.on.clipboard", view: ClipboardModule())
    ]
    
    var body: some View {
        VStack(spacing: settings.moduleSpacing) {
            if isVisible {
                if !modules.isEmpty {
                    modules[currentModuleIndex].view
                        .transition(.opacity)
                }
            }
        }
        .frame(width: settings.notchSize.width, height: settings.notchSize.height)
        .background(Color.clear)
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.width < -50 {
                        withAnimation(.easeInOut(duration: settings.animationSpeed)) {
                            currentModuleIndex = (currentModuleIndex + 1) % modules.count
                        }
                    } else if gesture.translation.width > 50 {
                        withAnimation(.easeInOut(duration: settings.animationSpeed)) {
                            currentModuleIndex = (currentModuleIndex - 1 + modules.count) % modules.count
                        }
                    }
                }
        )
        .onAppear {
            if settings.autoHide {
                startAutoHideTimer()
            }
        }
    }
    
    private func startAutoHideTimer() {
        Timer.scheduledTimer(withTimeInterval: settings.autoHideDelay, repeats: true) { _ in
            withAnimation(.easeInOut(duration: settings.animationSpeed)) {
                isVisible = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: settings.animationSpeed)) {
                    isVisible = true
                }
            }
        }
    }
} 
