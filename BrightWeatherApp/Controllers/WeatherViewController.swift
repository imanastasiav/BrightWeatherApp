//
//  ViewController.swift
//  BrightWeatherApp
//
//  Created by Анастасия on 03.06.2025.
//

import UIKit

final class CurrentWeatherViewController: UIViewController {

    private let viewModel = WeatherViewModel()

    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let windLabel = UILabel()
    private let humidityLabel = UILabel()
    private let iconImageView = UIImageView()

    private let tableView = UITableView()
    private var forecastData: [ForecastViewData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchWeather(forLatitude: 55.75, longitude: 37.62) // Москва
    }

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] data in
            DispatchQueue.main.async {
                self?.cityLabel.text = data.city
                self?.temperatureLabel.text = data.temperatureText
                self?.windLabel.text = data.windSpeedText
                self?.humidityLabel.text = data.humidityText
                self?.forecastData = data.forecast
                self?.tableView.reloadData()
                if let iconURL = data.iconURL {
                    self?.loadIcon(from: iconURL)
                }
            }
        }

        viewModel.onError = { errorMessage in
            print("Ошибка: \(errorMessage)")
        }
    }

    private func setupUI() {
        view.backgroundColor = .white

        cityLabel.font = .boldSystemFont(ofSize: 24)
        temperatureLabel.font = .systemFont(ofSize: 20)
        windLabel.font = .systemFont(ofSize: 16)
        humidityLabel.font = .systemFont(ofSize: 16)
        iconImageView.contentMode = .scaleAspectFit

        let headerStack = UIStackView(arrangedSubviews: [cityLabel, temperatureLabel, windLabel, humidityLabel, iconImageView])
        headerStack.axis = .vertical
        headerStack.spacing = 10
        headerStack.alignment = .center

        tableView.dataSource = self
        tableView.register(ForecastCell.self, forCellReuseIdentifier: "ForecastCell")
        tableView.rowHeight = 80

        let mainStack = UIStackView(arrangedSubviews: [headerStack, tableView])
        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    private func loadIcon(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.iconImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

extension CurrentWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecast = forecastData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        cell.configure(with: forecast)
        return cell
    }
}

final class ForecastCell: UITableViewCell {
    private let dateLabel = UILabel()
    private let tempLabel = UILabel()
    private let windLabel = UILabel()
    private let humidityLabel = UILabel()
    private let iconImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let stack = UIStackView(arrangedSubviews: [iconImageView, dateLabel, tempLabel, windLabel, humidityLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        iconImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with data: ForecastViewData) {
        dateLabel.text = data.date
        tempLabel.text = data.temperature
        windLabel.text = data.wind
        humidityLabel.text = data.humidity

        if let url = data.iconURL {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.iconImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
