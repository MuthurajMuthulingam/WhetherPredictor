//
//  WeatherItemTableViewCell.swift
//  WeatherPredictor
//
//  Created by Muthuraj Muthulingam on 22/06/20.
//  Copyright © 2020 Muthuraj Muthulingam. All rights reserved.
//

import UIKit

class WeatherItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
}

extension WeatherItemTableViewCell {
    func updateView(with data: WeatherItem) {
        descriptionLabel.text = data.weather?.first?.description
        temperatureLabel.text = data.temperature?.displayableFormat ?? ""
        dateLabel.text = data.dateString
    }
}
