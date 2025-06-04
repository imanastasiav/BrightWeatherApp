//
//  WeatherViewModel.swift
//  BrightWeatherApp
//
//  Created by Анастасия on 04.06.2025.
//

import Foundation

struct ForecastViewData {
    let date: String
    let temperature: String
    let wind: String
    let humidity: String
    let iconURL: URL?
}

struct WeatherViewData {
    let city: String
    let temperatureText: String
    let windSpeedText: String
    let humidityText: String
    let iconURL: URL?
    let forecast: [ForecastViewData]

    init(from weather: Weather) {
        self.city = weather.cityName
        self.temperatureText = "\(Int(weather.temperature))°C"
        self.windSpeedText = "Ветер: \(Int(weather.windSpeed)) км/ч"
        self.humidityText = "Влажность: \(weather.humidity)%"
        self.iconURL = URL(string: weather.conditionIconURL)
        self.forecast = weather.dailyForecast.map {
            ForecastViewData(
                date: $0.date,
                temperature: "\(Int($0.temperature))°C",
                wind: "\(Int($0.windSpeed)) км/ч",
                humidity: "\(Int($0.humidity))%",
                iconURL: URL(string: $0.iconURL)
            )
        }
    }
}

final class WeatherViewModel {
    var onDataUpdated: ((WeatherViewData) -> Void)?
    var onError: ((String) -> Void)?

    private let networkManager = NetworkWeatherManager()

    func fetchWeather(forLatitude lat: Double, longitude lon: Double) {
        networkManager.fetchWeather(latitude: lat, longitude: lon) { [weak self] weather in
            let viewData = WeatherViewData(from: weather)
            self?.onDataUpdated?(viewData)
        }
    }
}
