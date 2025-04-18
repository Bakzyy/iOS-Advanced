import Foundation
import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentConditions: LoadingState<CurrentConditions> = .idle
    @Published var forecast: LoadingState<[ForecastDay]> = .idle
    @Published var airQuality: LoadingState<AirQuality> = .idle
    @Published var alerts: LoadingState<[Alert]> = .idle
    @Published var radar: LoadingState<WeatherRadar> = .idle
    @Published var location: String = "Boston"

    private var weatherTask: Task<Void, Never>?
    private let apiKey = "YOUR_API_KEY"

    func fetchAllWeatherData() {
        cancelFetch()

        currentConditions = .loading
        forecast = .loading
        airQuality = .loading
        alerts = .loading
        radar = .loading

        weatherTask = Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.fetchCurrentConditions() }
                group.addTask { await self.fetchForecast() }
                group.addTask { await self.fetchAirQuality() }
                group.addTask { await self.fetchAlerts() }
                group.addTask { await self.fetchRadar() }
            }
        }
    }

    func cancelFetch() {
        weatherTask?.cancel()
        weatherTask = nil
    }

    private func fetchCurrentConditions() async {
        do {
            let city = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? location
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(OpenWeatherCurrent.self, from: data)
            currentConditions = .success(CurrentConditions(temp: decoded.main.temp, description: decoded.weather.first?.description ?? "N/A"))
        } catch {
            currentConditions = .failure(error)
        }
    }

    private func fetchForecast() async {
        do {
            let city = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? location
            let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(OpenWeatherForecast.self, from: data)
            let days = Dictionary(grouping: decoded.list) { $0.dt_txt.prefix(10) }
                .compactMap { date, values -> ForecastDay? in
                    guard let min = values.map(\ .main.temp_min).min(), let max = values.map(\ .main.temp_max).max() else { return nil }
                    return ForecastDay(date: String(date), minTemp: min, maxTemp: max)
                }
            forecast = .success(days)
        } catch {
            forecast = .failure(error)
        }
    }

    private func fetchAirQuality() async {
        do {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=42.3601&lon=-71.0589&appid=\(apiKey)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(OpenWeatherAirQuality.self, from: data)
            airQuality = .success(AirQuality(aqi: decoded.list.first?.main.aqi ?? 0))
        } catch {
            airQuality = .failure(error)
        }
    }

    private func fetchAlerts() async {
        do {
            alerts = .success([Alert(title: "No Alerts", description: "All clear")])
        } catch {
            alerts = .failure(error)
        }
    }

    private func fetchRadar() async {
        do {
            let url = "https://tile.openweathermap.org/map/clouds_new/10/295/191.png?appid=\(apiKey)"
            radar = .success(WeatherRadar(imageUrl: url))
        } catch {
            radar = .failure(error)
        }
    }
}
