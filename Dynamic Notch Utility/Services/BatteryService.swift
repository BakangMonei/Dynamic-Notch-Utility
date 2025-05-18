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
            let info = IOPSGetPowerSourceDescription(snapshot, source).takeRetainedValue() as NSDictionary
            
            if let capacity = info[kIOPSCurrentCapacityKey] as? Int {
                batteryLevel = Double(capacity) / 100.0
            }
            
            if let isCharging = info[kIOPSIsChargingKey] as? Bool {
                self.isCharging = isCharging
            }
            
            if let timeRemaining = info[kIOPSTimeToEmptyKey] as? Int {
                self.timeRemaining = TimeInterval(timeRemaining * 60)
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
} 