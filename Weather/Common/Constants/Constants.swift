//
//  Constants.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

struct Constants {
	//MARK: User interface
	//MARK: Table view cell identifiers
	let cityListCell = "cityListCell"
	let contactUsTextFieldCell = String(describing: ContactUsInputTableViewCell.self)
	let contactUsButtonCell = String(describing: ContactUsButtonTableViewCell.self)
	let weatherDetailsCell = String(describing: WeatherDetailsTableViewCell.self)
	
	//MARK: Misc
	let cityListFileName = "cities"
	let weatherDetails = "weatherDetails"
	let json = "json"
}
