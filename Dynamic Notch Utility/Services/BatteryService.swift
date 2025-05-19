import Foundation
import IOKit.ps

class BatteryService: ObservableObject {
    @Published var batteryLevel: Double = 0
    @Published var isCharging: Bool = false
    @Published var timeRemaining: TimeInterval = 0
    
    private var timer: Timer?
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        updateBatteryInfo()
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            self?.updateBatteryInfo()
        }
    }
    
    private func updateBatteryInfo() {
        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array
        
        for source in sources {
            guard let info = IOPSGetPowerSourceDescription(snapshot, source)?.takeUnretainedValue() as? [String: Any] else { continue }
            
            if let current = info[kIOPSCurrentCapacityKey as String] as? Int,
               let max = info[kIOPSMaxCapacityKey as String] as? Int, max > 0 {
                batteryLevel = Double(current) / Double(max)
            }
            
            if let isCharging = info[kIOPSIsChargingKey as String] as? Bool {
                self.isCharging = isCharging
            }
            
            if let timeRemaining = info[kIOPSTimeToEmptyKey as String] as? Int {
                self.timeRemaining = TimeInterval(timeRemaining * 60)
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
} 