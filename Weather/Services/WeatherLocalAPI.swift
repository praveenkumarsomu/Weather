//
//  CityStaticListAPI.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

/// Fetch list of cities from the local json file
class WeatherLocalAPI: WeatherStoreProtocol {
	
	func fetchCityList() async throws -> Data {
		let constants = Constants()
		guard let filePath = Bundle.main.path(forResource: constants.cityListFileName, ofType: constants.json) else {
			throw WeatherAPIError.fileNotFound
		}
		let url = URL(fileURLWithPath: filePath)
		let content = try Data(contentsOf: url, options: .alwaysMapped)
		return content
	}
	func getWeatherDetails(_ url: URL) async throws -> Data {
		let constants = Constants()
		guard let filePath = Bundle.main.path(forResource: constants.weatherDetails, ofType: constants.json) else {
			throw WeatherAPIError.fileNotFound
		}
		let url = URL(fileURLWithPath: filePath)
		let content = try Data(contentsOf: url, options: .alwaysMapped)
		return content
	}
}
