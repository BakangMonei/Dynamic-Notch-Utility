import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupWindow()
    }
    
    private func setupWindow() {
        let contentView = NotchOverlayView()
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 200, height: 30),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        window?.center()
        window?.contentView = NSHostingView(rootView: contentView)
        window?.backgroundColor = .clear
        window?.isOpaque = false
        window?.hasShadow = false
        window?.level = .floating
        window?.collectionBehavior = [.canJoinAllSpaces, .stationary]
        window?.ignoresMouseEvents = false
        window?.makeKeyAndOrderFront(nil)
        
        // Position window at the notch
        if let screen = NSScreen.main {
            let notchHeight: CGFloat = 30
            let screenHeight = screen.frame.height
            window?.setFrameOrigin(NSPoint(
                x: (screen.frame.width - window!.frame.width) / 2,
                y: screenHeight - notchHeight
            ))
        }
    }
} 