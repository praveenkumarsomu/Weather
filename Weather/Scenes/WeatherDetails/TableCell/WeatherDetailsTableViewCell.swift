//
//  WeatherDetailsTableViewCell.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

/// Weather details display table view cell. As of now it displays a simple view as view very lightly coupled with application logic can modify it very easily in future.
class WeatherDetailsTableViewCell: UITableViewCell {
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var lastUpdatedOnLabel: UILabel!
	@IBOutlet weak var temparatureLabel: UILabel!
	@IBOutlet weak var conditionLabel: UILabel!
	@IBOutlet weak var feelsLikeLabel: UILabel!
	let constants: Constants = Constants()
	/// Display weather details api response on table cell, usally it was called from `WeatherDetailsViewController`
	/// - Parameter viewModel: <#viewModel description#>
	func configureUI(_ viewModel: WeatherDetailsModel.ViewModel) {
		countryNameLabel.text = viewModel.cityName
		lastUpdatedOnLabel.text = "\(viewModel.lastUpdatedLabel) \(viewModel.lastUpdatedTime)"
		temparatureLabel.text = "\(constants.currentTemparatureIs) \(viewModel.temparature) \(viewModel.temparatureUnit)"
		conditionLabel.text = "\(constants.weatherCondition) \(viewModel.weatherCondition)"
		feelsLikeLabel.text = "\(constants.itFeelsLike) \(viewModel.feelsLike) \(viewModel.temparatureUnit)"
	}
    
}
