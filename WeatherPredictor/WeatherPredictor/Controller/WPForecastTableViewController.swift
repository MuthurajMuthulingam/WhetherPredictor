//
//  WPForecastTableViewController.swift
//  WeatherPredictor
//
//  Created by Muthuraj Muthulingam on 21/06/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit
import CoreLocation

class WPForecastTableViewController: UITableViewController {
    private var locationManager: MMLocationManager = MMLocationManager()
    private lazy var myLocation: CLLocation? = nil
    private var weatherInfoList: [WeatherItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: WeatherItemTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: WeatherItemTableViewCell.self))
        self.clearsSelectionOnViewWillAppear = false
        locationManager.delegate = self
        locationManager.prepareLocationManager()
        title = "My Weather Forecast"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startMonitoring()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopLocationMonitoring()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherInfoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherItemTableViewCell.self), for: indexPath)
        if let weatherCell = cell as? WeatherItemTableViewCell {
            weatherCell.updateView(with: weatherInfoList[indexPath.row])
        }
        return cell
    }
}

extension WPForecastTableViewController: MMLocationManagerDelegate {
    // MARK: - Location Manager Delegates
    func locationManager(_ manager: MMLocationManager, didGenerateEvent event: MMLocationManagerEvent) {
        switch event {
        case let .locationUpdate(newLocation):
            guard myLocation == nil else { return }
            myLocation = newLocation
            WPNetworkModelHandler.fetchForecast(for: newLocation.coordinate) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(result):
                    do {
                        let weathers = try JSONDecoder().decode(WeatherItemInfo.self, from: result)
                        self.weatherInfoList = weathers.list?.sorted(by: { $0.date < $1.date }) ?? []
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
