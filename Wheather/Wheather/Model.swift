import Foundation

struct CurrentConditions: Codable {
    let temp: Double
    let description: String
}

struct ForecastDay: Codable, Identifiable {
    var id: String { date }
    let date: String
    let minTemp: Double
    let maxTemp: Double
}

struct AirQuality: Codable {
    let aqi: Int
}

struct Alert: Codable, Identifiable {
    var id: String { title }
    let title: String
    let description: String
}

struct WeatherRadar: Codable {
    let imageUrl: String
}

enum LoadingState<T> {
    case idle, loading, success(T), failure(Error)
}

struct OpenWeatherCurrent: Codable {
    struct Main: Codable { let temp: Double }
    struct Weather: Codable { let description: String }
    let main: Main
    let weather: [Weather]
}

struct OpenWeatherForecast: Codable {
    struct ForecastMain: Codable { let temp_min: Double; let temp_max: Double }
    struct ForecastItem: Codable {
        let dt_txt: String
        let main: ForecastMain
    }
    let list: [ForecastItem]
}

struct OpenWeatherAirQuality: Codable {
    struct AQIMain: Codable { let aqi: Int }
    struct AQIItem: Codable { let main: AQIMain }
    let list: [AQIItem]
}

