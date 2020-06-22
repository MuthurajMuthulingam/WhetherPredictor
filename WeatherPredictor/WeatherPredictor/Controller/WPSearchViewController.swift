//
//  WPSearchViewController.swift
//  WeatherPredictor
//
//  Created by Muthuraj Muthulingam on 21/06/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit
import CoreLocation

class WPSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    private var cityWeatherInfo: [[String: WeatherInfo]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search by city"
    }
    
    @IBAction func searchClicked(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return cityWeatherInfo.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherItemTableViewCell.self), for: indexPath)
        if let weatherCell = cell as? WeatherItemTableViewCell {
            //weatherCell.updateView(with: weatherInfoList[indexPath.row])
        }
        return cell
    }
}
