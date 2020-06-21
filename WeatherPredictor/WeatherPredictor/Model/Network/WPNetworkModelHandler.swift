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
    class func fetchForecast(for location: CLLocationCoordinate2D, completion: @escaping WPNetworkModelHandlerResponse) {
        let weatherForcastAPIString: String = "http://samples.openweathermap.org/data/2.5/forecast?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)"
        guard let url = URL(string: weatherForcastAPIString) else { return }
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
}
