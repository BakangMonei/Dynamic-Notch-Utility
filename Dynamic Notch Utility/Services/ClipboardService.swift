import Foundation
import AppKit

class ClipboardService: ObservableObject {
    @Published var clipboardItems: [ClipboardItem] = []
    @Published var currentItem: ClipboardItem?
    
    private let maxItems = 10
    private var timer: Timer?
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkClipboard()
        }
    }
    
    private func checkClipboard() {
        let pasteboard = NSPasteboard.general
        
        if let string = pasteboard.string(forType: .string) {
            addItem(.text(string))
        } else if let image = pasteboard.readObjects(forClasses: [NSImage.self], options: nil)?.first as? NSImage {
            addItem(.image(image))
        }
    }
    
    private func addItem(_ item: ClipboardItem) {
        if currentItem != item {
            currentItem = item
            clipboardItems.insert(item, at: 0)
            if clipboardItems.count > maxItems {
                clipboardItems.removeLast()
            }
        }
    }
    
    func copyItem(_ item: ClipboardItem) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        
        switch item {
        case .text(let string):
            pasteboard.setString(string, forType: .string)
        case .image(let image):
            pasteboard.writeObjects([image])
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

enum ClipboardItem: Hashable {
    case text(String)
    case image(NSImage)
    
    static func == (lhs: ClipboardItem, rhs: ClipboardItem) -> Bool {
        switch (lhs, rhs) {
        case (.text(let l), .text(let r)):
            return l == r
        case (.image(let l), .image(let r)):
            return l == r
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .text(let string):
            hasher.combine(0) // Case discriminator
            hasher.combine(string)
        case .image(let image):
            hasher.combine(1) // Case discriminator
            hasher.combine(image)
        }
    }
} 