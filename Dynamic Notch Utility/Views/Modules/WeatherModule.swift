import SwiftUI
import WeatherKit

struct WeatherModule: View {
    @StateObject private var weatherService = WeatherService()
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 4) {
            if let current = weatherService.currentWeather {
                HStack(spacing: 8) {
                    Image(systemName: current.symbolName)
                        .font(.system(size: 16))
                    
                    Text("\(Int(current.temperature.value))°")
                        .font(.system(size: 12, weight: .medium))
                    
                    if !isExpanded {
                        Text(current.condition.description)
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.7))
                .cornerRadius(8)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                
                if isExpanded {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(weatherService.dailyForecast.prefix(3), id: \.date) { day in
                            HStack {
                                Text(day.date.formatted(.dateTime.weekday(.abbreviated)))
                                    .font(.system(size: 10))
                                Spacer()
                                Image(systemName: day.symbolName)
                                    .font(.system(size: 10))
                                Text("\(Int(day.lowTemperature.value))° - \(Int(day.highTemperature.value))°")
                                    .font(.system(size: 10))
                            }
                        }
                    }
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
                }
            } else {
                Text("Loading weather...")
                    .font(.system(size: 12))
            }
        }
    }
} 