//
//  WeatherDetailsTableViewCell.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var lastUpdatedOnLabel: UILabel!
	@IBOutlet weak var temparatureLabel: UILabel!
	@IBOutlet weak var conditionLabel: UILabel!
	@IBOutlet weak var feelsLikeLabel: UILabel!
	let constants: Constants = Constants()
	func configureUI(_ viewModel: WeatherDetailsModel.ViewModel) {
		countryNameLabel.text = viewModel.cityName
		lastUpdatedOnLabel.text = "\(viewModel.lastUpdatedLabel) \(viewModel.lastUpdatedTime)"
		temparatureLabel.text = "\(constants.currentTemparatureIs) \(viewModel.temparature) \(viewModel.temparatureUnit)"
		conditionLabel.text = "\(constants.weatherCondition) \(viewModel.weatherCondition)"
		feelsLikeLabel.text = "\(constants.itFeelsLike) \(viewModel.feelsLike) \(viewModel.temparatureUnit)"
	}
    
}
