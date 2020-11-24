//
//  CityWeatherCell.swift
//  Weather
//
//  Created by Калинин Артем Валериевич on 22.11.2020.
//

import UIKit

class CityWeatherCell: UITableViewCell {
    
    static let identifire = "CityWeatherCell"
    
    private var city = UILabel()
    private var temperature = UILabel()
    private var weather = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCity()
        constraints()
        setupWeather()
        setupTemperature()
    }
    
    func setup(with usingCity: Weather?) {
        guard let unwrapCity = usingCity else {return}
        city.text = unwrapCity.geo_object?.locality?.name
        temperature.text = String(unwrapCity.fact?.temp ?? 0) + " ℃"
        weather.text = Network.shared.createWeather(with: usingCity)
    }
    
    private func setupWeather() {
        weather.font = .systemFont(ofSize: 20)
        weather.numberOfLines = 2
        weather.textColor = .black
        weather.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTemperature() {
        temperature.font = .systemFont(ofSize: 30)
        temperature.textColor = .orange
        temperature.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCity() {
        city.textColor = .orange
        city.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func constraints() {
        contentView.addSubview(city)
        contentView.addSubview(temperature)
        contentView.addSubview(weather)
        
        let constraints = [
            city.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15),
            city.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            weather.topAnchor.constraint(equalTo: city.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            weather.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weather.trailingAnchor.constraint(equalTo: temperature.safeAreaLayoutGuide.leadingAnchor, constant: -20),
            
            temperature.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            temperature.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
