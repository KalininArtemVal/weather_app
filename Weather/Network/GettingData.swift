//
//  GettingData.swift
//  Weather
//
//  Created by Калинин Артем Валериевич on 24.11.2020.
//

import Foundation
import UIKit

class GettingData {
    
    private let moscow = "lat=55.75396&lon=37.620393&extra=true"
    private let washingtonDC = "lat=38.88924&lon=-77.05063&extra=true"
    private let amsterdam = "lat=52.37403&lon=4.88969&extra=true"
    private let saintPetersburg = "lat=59.89444&lon=30.26417&extra=true"
    private let barcelona = "lat=41.3888&lon=2.15899&extra=true"
    private let london = "lat= 51.50735&lon=-0.127660&extra=true"
    private let kiev = "lat=50.4547&lon=30.5238&extra=true"
    private let berlin = "lat=52.52000&lon=13.40495&extra=true"
    private let paris = "lat=48.8534&lon=2.3488&extra=true"
    private let tallinn = "lat=59.42193&lon=24.74336&extra=true"
    
    static let shared = GettingData()
    private init() {}
    
    func getCities() -> [String] {
        let cities = [moscow,washingtonDC,amsterdam,saintPetersburg,barcelona,london,kiev,berlin,paris,tallinn]
        return cities
    }
}
