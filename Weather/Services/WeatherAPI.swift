//
//  WeatherAPI.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

///
class WeatherAPI: WeatherStoreProtocol {
	
	/// Placeholder function for real contact us API
	func fetchCityList() throws -> Data {
		return Data()
	}
	func getWeatherDetails(_ url: URL) async throws -> Data {
		let (data, response) = try await URLSession.shared.data(from: url)
		guard let resonseCode = (response as? HTTPURLResponse)?.statusCode else {
			throw WeatherAPIError.genericError
		}
		guard resonseCode == 200 else {
			throw WeatherAPIError.httpError(resonseCode)
		}
		return data
	}
}
