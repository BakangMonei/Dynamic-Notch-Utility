import Foundation
import IOKit

class SystemStatsService: ObservableObject {
    @Published var cpuUsage: Double = 0
    @Published var memoryUsage: Double = 0
    @Published var diskUsage: Double = 0
    @Published var networkStats: NetworkStats = NetworkStats()
    
    private var timer: Timer?
    private var hostInfo: host_cpu_load_info?
    
    struct NetworkStats {
        var bytesIn: UInt64 = 0
        var bytesOut: UInt64 = 0
        var lastBytesIn: UInt64 = 0
        var lastBytesOut: UInt64 = 0
        var bytesInPerSecond: Double = 0
        var bytesOutPerSecond: Double = 0
    }
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateStats()
        }
    }
    
    private func updateStats() {
        updateCPUUsage()
        updateMemoryUsage()
        updateDiskUsage()
        updateNetworkStats()
    }
    
    private func updateCPUUsage() {
        var cpuInfo: processor_info_array_t?
        var numCpuInfo: mach_msg_type_number_t = 0
        var numCPUsU: natural_t = 0

        let result = host_processor_info(
            mach_host_self(),
            PROCESSOR_CPU_LOAD_INFO,
            &numCPUsU,
            &cpuInfo,
            &numCpuInfo
        )

        guard result == KERN_SUCCESS, let cpuInfo = cpuInfo else {
            return
        }

        let cpuLoadInfo = UnsafeMutablePointer<processor_cpu_load_info_t>(OpaquePointer(cpuInfo)).pointee
        let numCPUs = Int(numCPUsU)

        var totalUser: UInt32 = 0
        var totalSystem: UInt32 = 0
        var totalIdle: UInt32 = 0

        for i in 0..<numCPUs {
            let cpu = cpuLoadInfo.advanced(by: i).pointee
            totalUser += cpu.cpu_ticks.0
            totalSystem += cpu.cpu_ticks.1
            totalIdle += cpu.cpu_ticks.2
        }

        let totalTicks = Double(totalUser + totalSystem + totalIdle)
        cpuUsage = totalTicks > 0 ? Double(totalUser + totalSystem) / totalTicks : 0

        // Deallocate the memory
        let cpuInfoSize = Int(numCpuInfo) * MemoryLayout<integer_t>.stride
        vm_deallocate(mach_task_self_, vm_address_t(bitPattern: cpuInfo), vm_size_t(cpuInfoSize))
    }

    
    private func updateMemoryUsage() {
        var pagesize: vm_size_t = 0
        var count: mach_msg_type_number_t = UInt32(MemoryLayout<vm_statistics64_data_t>.stride / MemoryLayout<integer_t>.stride)
        var vmStats = vm_statistics64_data_t()
        
        host_page_size(mach_host_self(), &pagesize)
        
        let result = withUnsafeMutablePointer(to: &vmStats) { pointer in
            pointer.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { pointer in
                host_statistics64(mach_host_self(),
                                HOST_VM_INFO64,
                                pointer,
                                &count)
            }
        }
        
        guard result == KERN_SUCCESS else { return }
        
        let totalMemory = Double(vmStats.free_count + vmStats.active_count + vmStats.inactive_count + vmStats.wire_count) * Double(pagesize)
        let usedMemory = Double(vmStats.active_count + vmStats.inactive_count + vmStats.wire_count) * Double(pagesize)
        
        memoryUsage = usedMemory / totalMemory
    }
    
    private func updateDiskUsage() {
        let fileManager = FileManager.default
        guard let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.path else { return }
        
        do {
            let attributes = try fileManager.attributesOfFileSystem(forPath: path)
            let totalSize = attributes[.systemSize] as? NSNumber
            let freeSize = attributes[.systemFreeSize] as? NSNumber
            
            if let total = totalSize?.doubleValue,
               let free = freeSize?.doubleValue {
                diskUsage = (total - free) / total
            }
        } catch {
            print("Error getting disk usage: \(error)")
        }
    }
    
    private func updateNetworkStats() {
        // Note: This is a simplified version. For actual network stats,
        // you would need to use nettop or similar tools
        var stats = networkStats
        stats.lastBytesIn = stats.bytesIn
        stats.lastBytesOut = stats.bytesOut
        
        // Simulate network activity for demonstration
        stats.bytesIn += UInt64.random(in: 0...1000)
        stats.bytesOut += UInt64.random(in: 0...1000)
        
        stats.bytesInPerSecond = Double(stats.bytesIn - stats.lastBytesIn)
        stats.bytesOutPerSecond = Double(stats.bytesOut - stats.lastBytesOut)
        
        networkStats = stats
    }
    
    deinit {
        timer?.invalidate()
    }
} 
