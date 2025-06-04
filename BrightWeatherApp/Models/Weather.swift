//
//  Weather.swift
//  BrightWeatherApp
//
//  Created by Анастасия on 04.06.2025.
//

import Foundation

struct DailyForecast {
    let date: String
    let temperature: Double
    let windSpeed: Double
    let humidity: Double
    let conditionText: String
    let iconURL: String
}

struct Weather {
    let cityName: String
    let temperature: Double
    let windSpeed: Double
    let humidity: Int
    let conditionText: String
    let conditionIconURL: String
    let dailyForecast: [DailyForecast]

    init?(weatherData: WeatherData) {
        self.cityName = weatherData.location.name
        self.temperature = weatherData.current.temp_c
        self.windSpeed = weatherData.current.wind_kph
        self.humidity = weatherData.current.humidity
        self.conditionText = weatherData.current.condition.text
        self.conditionIconURL = "https:\(weatherData.current.condition.icon)"

        self.dailyForecast = weatherData.forecast.forecastday.map {
            DailyForecast(
                date: $0.date,
                temperature: $0.day.avgtemp_c,
                windSpeed: $0.day.maxwind_kph,
                humidity: $0.day.avghumidity,
                conditionText: $0.day.condition.text,
                iconURL: "https:\($0.day.condition.icon)"
            )
        }
    }
}
