import SwiftUI

struct BatteryModule: View {
    @StateObject private var batteryService = BatteryService()
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: batteryService.isCharging ? "battery.100.bolt" : "battery.100")
                .foregroundColor(batteryColor)
            
            Text("\(Int(batteryService.batteryLevel * 100))%")
                .font(.system(size: 12, weight: .medium))
            
            if batteryService.isCharging {
                Text("Charging")
                    .font(.system(size: 10))
                    .foregroundColor(.green)
            } else if batteryService.timeRemaining > 0 {
                Text(timeString(from: batteryService.timeRemaining))
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.black.opacity(0.7))
        .cornerRadius(8)
    }
    
    private var batteryColor: Color {
        if batteryService.isCharging {
            return .green
        } else if batteryService.batteryLevel < 0.2 {
            return .red
        } else if batteryService.batteryLevel < 0.4 {
            return .orange
        } else {
            return .white
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        return "\(hours)h \(minutes)m"
    }
} 
#Preview {
    BatteryModule()
}
