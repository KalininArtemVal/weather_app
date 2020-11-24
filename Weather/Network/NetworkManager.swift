//
//  NetworkManager.swift
//  Weather
//
//  Created by Калинин Артем Валериевич on 22.11.2020.
//

import Foundation
import UIKit

class Network {
    
    private var headerForJson = ["X-Yandex-API-Key":"0b88adbd-c6ce-41db-95c2-dac2af06ab5c"]
    let session = URLSession.shared
    
    private enum httpMethod: String {
        case GET
    }
    
    private enum Errors: Error {
        case body
        case response
        case request
        case data
        case parse
        case result
        case gettingUser
        case json
        case statusCode(Int)
    }
    
    static let shared = Network()
    private init() {}
    
    //MARK: - Get Weather
    
    func getWeather(city: String, competiton: @escaping (Result<Weather, Error>) -> Void) {
        guard let request = generateRequest(for: city,
                                            method: httpMethod.GET.rawValue,
                                            header: headerForJson,
                                            body: nil) else { return }
        print(request)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                competiton(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            if let data = data {
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    competiton( .success(weather))
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    //MARK: - Localisate Weather
    func createWeather(with weather: Weather?) -> String {
        var rusWeather = ""
        guard let weather = weather else {return ""}
        switch weather.fact?.condition {
        case "clear":
            rusWeather = "ясно"
        case "partly-cloudy":
            rusWeather = "малооблачно"
        case "cloudy":
            rusWeather = "облачно с прояснениями"
        case "overcast":
            rusWeather = "пасмурно"
        case "drizzle":
            rusWeather = "морось"
        case "light-rain":
            rusWeather = "небольшой дождь"
        case "rain":
            rusWeather = "дождь"
        case "moderate-rain ":
            rusWeather = "умеренно сильный дождьо"
        case "heavy-rain":
            rusWeather = "ясно"
        case "continuous-heavy-rain":
            rusWeather = "малооблачно"
        case "showers":
            rusWeather = "облачно с прояснениями"
        case "wet-snow":
            rusWeather = "пасмурно"
        case "snow":
            rusWeather = "морось"
        case "snow-showers":
            rusWeather = "небольшой дождь"
        case "hail":
            rusWeather = "дождь"
        case "thunderstorm":
            rusWeather = "умеренно сильный дождьо"
        case "thunderstorm-with-rain":
            rusWeather = "дождь"
        case "thunderstorm-with-hail":
            rusWeather = "дождь с грозой"
        default:
            rusWeather = "гроза с градом"
        }
        return rusWeather
    }
    
    //MARK: - Generate Request
    
    private func generateRequest(for city: String, method: String, header: [String: String]?, body: Data?) -> URLRequest? {
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?\(city)&extra=true") else {
            print("It will never heppend")
            
            "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&lang=ru_RU&extra=true"
            return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method

        if let header = header {
            request.allHTTPHeaderFields = header
        }
        if let body = body {
            request.httpBody = body
        }
        return request
    }
    
}

