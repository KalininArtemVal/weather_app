//
//  Model.swift
//  Weather
//
//  Created by Калинин Артем Валериевич on 23.11.2020.
//

import Foundation
import UIKit

struct Weather: Codable {
    let geo_object: GeoObject?
    let fact: Fact?
}

struct GeoObject: Codable {
    let country: Country?
    let province: Province?
    let locality: Locality?
}

struct Province: Codable {
    let name: String?
}

struct Locality: Codable {
    let name: String?
}

struct Country: Codable {
    let name: String?
}

struct Fact: Codable {
    let temp: Int?
    let wind_speed: Double?
    let condition: String?
    let icon: String?
}
