//
//  WPSearchViewController.swift
//  WeatherPredictor
//
//  Created by Muthuraj Muthulingam on 21/06/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit
import CoreLocation

class WPSearchViewController: UIViewController, MMLocationManagerDelegate {
    
    private lazy var locationManager: MMLocationManager = MMLocationManager()
    private lazy var myLocation: CLLocation? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.prepareLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startMonitoring()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopLocationMonitoring()
    }
    
    // MARK: - Location Manager Delegates
    func locationManager(_ manager: MMLocationManager, didGenerateEvent event: MMLocationManagerEvent) {
        switch event {
        case let .locationUpdate(newLocation):
            guard myLocation == nil else { return }
            myLocation = newLocation
            WPNetworkModelHandler.fetchForecast(for: newLocation.coordinate) { result in
                switch result {
                case let .success(result):
                    do {
                        let weathers = try JSONDecoder().decode(WeatherItemInfo.self, from: result)
                        
                        debugPrint("\(weathers)")
                    } catch let error {
                        debugPrint("Error: \(error)")
                    }
                    debugPrint("Result: \(result)")
                case let .failure(error):
                    debugPrint("Error : \(error)")
                }
            }
        }
    }
}

extension WeatherItemInfo {
    var filteredWeatherInfo: [FilteredWeatherInfo] {
        guard let unwrappedList = list else { return [] }
        var filteredWeatherInfo: [FilteredWeatherInfo] = []
        var filteredDataDict: [Double: [WeatherItem]] = [:]
        for item in unwrappedList {
            let newWeatherItem: WeatherItem = WeatherItem(date: item.date, dateString: item.dateString, wind: item.wind, temperature: item.temperature, weather: item.weather)
            if let weatherItemList = filteredDataDict[item.date] {
                var newWeatherInfoList = weatherItemList
                newWeatherInfoList.append(newWeatherItem)
                filteredDataDict[item.date] = newWeatherInfoList
            } else {
                filteredDataDict[item.date] = [newWeatherItem]
            }
        }
        return filteredWeatherInfo
    }
}
