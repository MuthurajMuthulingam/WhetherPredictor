//
//  MMLocationManager.swift
//  WeatherPredictor
//
//  Created by Muthuraj Muthulingam on 21/06/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import Foundation
import CoreLocation

enum MMLocationManagerEvent {
    case locationUpdate(_ newLocation: CLLocation)
}

protocol MMLocationManagerDelegate: class {
    func locationManager(_ manager: MMLocationManager, didGenerateEvent event: MMLocationManagerEvent)
}

final class MMLocationManager: NSObject, CLLocationManagerDelegate {
    private lazy var locationManager: CLLocationManager = CLLocationManager()
    
    // MARK: - Public Properties
    weak var delegate: MMLocationManagerDelegate?
    
    // MARK: - Public Helpers
    func prepareLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func startMonitoring() {
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func stopLocationMonitoring() {
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    
    // MARK: - Location Manager Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        delegate?.locationManager(self, didGenerateEvent: .locationUpdate(newLocation))
    }
}
