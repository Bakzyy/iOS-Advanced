import SwiftUI
import Foundation

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchQuery = ""
    @State private var selectedForecast: ForecastDay?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter city", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    Button("Search") {
                        viewModel.location = searchQuery
                        viewModel.fetchAllWeatherData()
                    }
                    .padding(.trailing)
                }
                .padding(.top)

                ScrollView {
                    VStack(spacing: 20) {
                        WeatherComponentView(title: "Current Conditions", state: viewModel.currentConditions) { data in
                            VStack(alignment: .leading) {
                                Text("Temp: \(data.temp, specifier: "%.1f")°C")
                                Text("Description: \(data.description)")
                            }
                        }

                        WeatherComponentView(title: "5-Day Forecast", state: viewModel.forecast) { days in
                            VStack(alignment: .leading) {
                                ForEach(days) { day in
                                    Button(action: { selectedForecast = day }) {
                                        Text("\(day.date): \(day.minTemp)° - \(day.maxTemp)°C")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }

                        WeatherComponentView(title: "Air Quality", state: viewModel.airQuality) { data in
                            Text("AQI: \(data.aqi)")
                        }

                        WeatherComponentView(title: "Alerts", state: viewModel.alerts) { alerts in
                            VStack(alignment: .leading) {
                                ForEach(alerts) { alert in
                                    Text("\(alert.title): \(alert.description)")
                                }
                            }
                        }

                        WeatherComponentView(title: "Radar Image", state: viewModel.radar) { radar in
                            AsyncImage(url: URL(string: radar.imageUrl)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 200)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Weather Dashboard")
            .toolbar {
                Button("Refresh") {
                    viewModel.fetchAllWeatherData()
                }
            }
            .onAppear {
                viewModel.fetchAllWeatherData()
            }
            .sheet(item: $selectedForecast) { forecast in
                VStack(spacing: 16) {
                    Text("Details for \(forecast.date)")
                        .font(.title2)
                    Text("Min Temp: \(forecast.minTemp)°C")
                    Text("Max Temp: \(forecast.maxTemp)°C")
                }
                .padding()
            }
        }
    }
}

