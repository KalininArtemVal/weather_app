//
//  DetailViewController.swift
//  Weather
//
//  Created by Калинин Артем Валериевич on 22.11.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var city = UILabel()
    private var temperature = UILabel()
    private var weather = UILabel()
    
    
    var gettingCity: Weather?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCity()
        setupWeather()
        setupTemperature()
        setupConstraints()
        setupParametrs()
    }
    
    //MARK: - Methods
    private func setupParametrs() {
        guard gettingCity != nil else {return}
        city.text = gettingCity?.geo_object?.locality?.name
        temperature.text = String(gettingCity?.fact?.temp ?? 0) + " ℃"
        weather.text = Network.shared.createWeather(with: gettingCity)
    }
    
    private func setupCity() {
        city.font = .systemFont(ofSize: 25)
        city.textColor = .darkGray
        city.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTemperature() {
        temperature.font = .systemFont(ofSize: 32)
        temperature.textColor = .darkGray
        temperature.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupWeather() {
        weather.font = .systemFont(ofSize: 20)
        weather.textColor = .darkGray
        weather.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        view.addSubview(city)
        view.addSubview(temperature)
        view.addSubview(weather)
        
        let constraints = [
            city.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            city.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            
            temperature.topAnchor.constraint(equalTo: city.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            temperature.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            
            weather.topAnchor.constraint(equalTo: temperature.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            weather.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
