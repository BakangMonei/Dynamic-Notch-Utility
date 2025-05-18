import Foundation
import WeatherKit
import CoreLocation

class WeatherService: NSObject, ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyForecast: [HourWeather] = []
    @Published var dailyForecast: [DayWeather] = []
    @Published var location: CLLocation?
    
    private let weatherService = WeatherKit.WeatherService()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchWeather() async {
        guard let location = location else { return }
        
        do {
            let weather = try await weatherService.weather(for: location)
            await MainActor.run {
                self.currentWeather = weather.currentWeather
                self.hourlyForecast = Array(weather.hourlyForecast.forecast.prefix(24))
                self.dailyForecast = Array(weather.dailyForecast.forecast.prefix(7))
            }
        } catch {
            print("Error fetching weather: \(error)")
        }
    }
}

extension WeatherService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        Task {
            await fetchWeather()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error)")
    }
} 