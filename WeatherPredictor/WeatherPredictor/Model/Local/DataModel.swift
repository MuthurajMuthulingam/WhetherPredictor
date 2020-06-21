//
//  DataModel.swift
//  WeatherPredictor
//
//  Created by Muthuraj Muthulingam on 21/06/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import Foundation

struct WeatherItemInfo: Codable {
    let list: [WeatherItem]?
}

struct WeatherItem: Codable {
    let date: Double
    let dateString: String
    let wind: WindInfo?
    let temperature: TemperatureInfo?
    let weather: [WeatherInfo]?
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case dateString = "dt_txt"
        case temperature = "main"
        case wind
        case weather
    }
}

struct WindInfo: Codable {
    let speed: Double?
    let degree: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}

struct TemperatureInfo: Codable {
    let temperature: Double?
    let tempMin: Double?
    let tempMax: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WeatherInfo: Codable {
    let description: String?
}

struct FilteredWeatherInfo {
    var date: Double
    var dateString: String
    var list: [WeatherItem]
}
