//
//  WeatherManager.swift
//  BrightWeatherApp
//
//  Created by Анастасия on 03.06.2025.
//

import CoreLocation
import WeatherKit
import Foundation

struct NetworkWeatherManager {
    let apiKey = "ed83bf2818c242b19c993539250406"

    func fetchWeather(latitude: Double, longitude: Double, completionHandler: @escaping (Weather) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?q=moscow&days=5&key=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }

            if let weather = self.parseJSON(withData: data) {
                completionHandler(weather)
            }
        }

        task.resume()
    }

    func parseJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            return Weather(weatherData: weatherData)
        } catch {
            print("JSON Parsing Error: \(error.localizedDescription)")
            return nil
        }
    }
}
