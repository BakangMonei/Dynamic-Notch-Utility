import Foundation
import AppKit
import CoreServices

class ScreenshotService: ObservableObject {
    @Published var recentScreenshots: [ScreenshotItem] = []
    @Published var isMonitoring: Bool = false
    
    private let maxItems = 10
    private var source: DispatchSourceFileSystemObject?
    private var directoryHandle: FileHandle?
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let screenshotURL = desktopURL.appendingPathComponent("Screenshots")
        
        do {
            try FileManager.default.createDirectory(at: screenshotURL, withIntermediateDirectories: true)
        } catch {
            print("Error creating Screenshots directory: \(error)")
        }
        
        guard let handle = try? FileHandle(forReadingFrom: screenshotURL) else { return }
        directoryHandle = handle
        
        let source = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: handle.fileDescriptor,
            eventMask: .write,
            queue: .main
        )
        
        source.setEventHandler { [weak self] in
            self?.loadRecentScreenshots()
        }
        
        source.setCancelHandler { [weak self] in
            self?.directoryHandle?.closeFile()
        }
        
        source.resume()
        self.source = source
        isMonitoring = true
        
        loadRecentScreenshots()
    }
    
    private func loadRecentScreenshots() {
        let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let screenshotURL = desktopURL.appendingPathComponent("Screenshots")
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(
                at: screenshotURL,
                includingPropertiesForKeys: [.creationDateKey],
                options: [.skipsHiddenFiles]
            )
            
            let screenshots = fileURLs
                .filter { $0.pathExtension.lowercased() == "png" }
                .compactMap { url -> ScreenshotItem? in
                    guard let image = NSImage(contentsOf: url),
                          let creationDate = try? url.resourceValues(forKeys: [.creationDateKey]).creationDate else {
                        return nil
                    }
                    return ScreenshotItem(image: image, url: url, date: creationDate)
                }
                .sorted { $0.date > $1.date }
                .prefix(maxItems)
            
            DispatchQueue.main.async {
                self.recentScreenshots = Array(screenshots)
            }
        } catch {
            print("Error loading screenshots: \(error)")
        }
    }
    
    func stopMonitoring() {
        source?.cancel()
        source = nil
        directoryHandle?.closeFile()
        directoryHandle = nil
        isMonitoring = false
    }
    
    deinit {
        stopMonitoring()
    }
}

struct ScreenshotItem: Identifiable, Hashable {
    let id = UUID()
    let image: NSImage
    let url: URL
    let date: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    static func == (lhs: ScreenshotItem, rhs: ScreenshotItem) -> Bool {
        lhs.url == rhs.url
    }
} 