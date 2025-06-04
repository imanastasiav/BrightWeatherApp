//
//  File.swift
//  BrightWeatherApp
//
//  Created by Анастасия on 04.06.2025.
//

import Foundation

struct WeatherData: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
}

struct Current: Codable {
    let temp_c: Double
    let wind_kph: Double
    let humidity: Int
    let condition: Condition
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
}

struct Day: Codable {
    let avgtemp_c: Double
    let maxwind_kph: Double
    let avghumidity: Double
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}
