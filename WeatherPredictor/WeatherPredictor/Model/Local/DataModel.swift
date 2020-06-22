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

extension TemperatureInfo {
    var displayableFormat: String {
        var displayTemperature: String = ""
        if let minTemperature = tempMin {
            displayTemperature = "Min : \(minTemperature.convertTemp(from: .kelvin, to: .celsius)))"
        }
        if let maxTemperature = tempMax {
            displayTemperature = "Max : \(maxTemperature.convertTemp(from: .kelvin, to: .celsius))"
        }
        if let minTemperature = tempMin,
            let maxTemperature = tempMax {
            displayTemperature = "Min : \(minTemperature.convertTemp(from: .kelvin, to: .celsius)) Max: \(maxTemperature.convertTemp(from: .kelvin, to: .celsius))"
        }
        return displayTemperature
    }
}

extension Double {
    var toDegree: Double {
            return self * 180 / .pi
    }
    
    func convertTemp(from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
      let mf = MeasurementFormatter()
      mf.numberFormatter.maximumFractionDigits = 0
      mf.unitOptions = .providedUnit
      let input = Measurement(value: self, unit: inputTempType)
      let output = input.converted(to: outputTempType)
      return mf.string(from: output)
    }
}

struct WeatherInfo: Codable {
    let description: String?
}
