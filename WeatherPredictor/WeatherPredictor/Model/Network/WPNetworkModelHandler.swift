//
//  WPNetworkModelHandler.swift
//  WeatherPredictor
//
//  Created by Muthuraj Muthulingam on 21/06/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import Foundation
import MMNetworkManager
import CoreLocation

private let apiKey: String = "da1b8587c011ba681bb76882510766b6"

typealias WPNetworkModelHandlerResponse = (_ result: WPAPIResult<Data>) -> Void
final class WPNetworkModelHandler {
    
    let weatherSearchAPIString: String = ""
}

enum WPAPIResult<T> {
    case success(result: T)
    case failure(error: Error)
}

// MARK: - Public Methods
extension WPNetworkModelHandler {
    class func performRequest(with apiString: String, completion: @escaping WPNetworkModelHandlerResponse) {
        guard let url = URL(string: apiString) else { return }
        MMRequest(from: url, params: nil, method: .get, responseType: .json, timeout: 60, headers: nil).execute { response, request in
            guard let error = response.error else {
                if let rawData = response.rawData {
                   completion(.success(result: rawData))
                }
                return
            }
            completion(.failure(error: error))
        }
    }
    
    class func fetchForecast(for location: CLLocationCoordinate2D, completion: @escaping WPNetworkModelHandlerResponse) {
        let weatherForcastAPIString: String = "http://samples.openweathermap.org/data/2.5/forecast?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)"
        performRequest(with: weatherForcastAPIString, completion: completion)
    }
    
    class func fetchWeather(forCiry city: String, completion: @escaping WPNetworkModelHandlerResponse) {
        // https://samples.openweathermap.org/data/2.5/weather?id=2172797&appid=439d4b804bc8187953eb36d2a8c26a02
        let weatherAPIString: String = "http://samples.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        performRequest(with: weatherAPIString, completion: completion)
    }
}
