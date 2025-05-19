import SwiftUI
import AppKit
import Foundation
import SwiftUICore

struct SystemStatsView: View {
    @StateObject private var statsService = SystemStatsService()
    
    var body: some View {
        VStack(spacing: 8) {
            StatBar(title: "CPU", value: statsService.cpuUsage)
            StatBar(title: "Memory", value: statsService.memoryUsage)
            StatBar(title: "Disk", value: statsService.diskUsage)
            
            HStack(spacing: 12) {
                NetworkStatView(
                    title: "Download",
                    value: statsService.networkStats.bytesInPerSecond,
                    unit: "B/s"
                )
                
                NetworkStatView(
                    title: "Upload",
                    value: statsService.networkStats.bytesOutPerSecond,
                    unit: "B/s"
                )
            }
        }
        .padding(8)
        .background(Color.black.opacity(0.8))
        .cornerRadius(8)
    }
}

struct StatBar: View {
    let title: String
    let value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(Int(value * 100))%")
                    .font(.system(size: 10))
                    .foregroundColor(.white)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 4)
                    
                    Rectangle()
                        .fill(usageColor)
                        .frame(width: geometry.size.width * value, height: 4)
                }
            }
            .frame(height: 4)
        }
    }
    
    private var usageColor: Color {
        switch value {
        case 0..<0.5:
            return .green
        case 0.5..<0.8:
            return .yellow
        default:
            return .red
        }
    }
}

struct NetworkStatView: View {
    let title: String
    let value: Double
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 10))
                .foregroundColor(.white)
            
            Text(formatValue(value))
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
        }
    }
    
    private func formatValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        let number = NSNumber(value: value)
        return "\(formatter.string(from: number) ?? "0") \(unit)"
    }
}

#Preview {
    SystemStatsView()
} 
