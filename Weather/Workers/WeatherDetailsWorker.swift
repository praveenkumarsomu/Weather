//
//  CityListWorker.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

protocol WeatherStoreProtocol {
	func fetchCityList() async throws -> Data
	func getWeatherDetails(_ url: URL) async throws -> Data
}
enum WeatherAPIError: Error {
	case fileNotFound
	case cityListNotFound
	case invalidURL
	case httpError(Int)
	case genericError
	case invalidData
}
class WeatherDetailsWorker {
	var weatherStore: WeatherStoreProtocol
	init(weatherStore: WeatherStoreProtocol) {
		self.weatherStore = weatherStore
	}
	/// Fetch data from the API
	/// As of now it just call function but in future if we want to extend functionality like off line support, etc we see more code from this function.
	/// - Returns: Returns city list data
	func fetchCityList() async throws -> Data {
		return try await weatherStore.fetchCityList()
	}
	func getWeatherDetails(for cityCode: String, degree: String) async throws -> Data {
		/// As of now hard coding this string we can extract this out when we want to implement multiple environments STG, Dev, etc.
		let urlString = String(format: "https://www.theweathernetwork.com/api/obsdata/%@/%@", cityCode, degree)
		guard let url = URL(string: urlString) else {
			throw WeatherAPIError.invalidURL
		}
		return try await weatherStore.getWeatherDetails(url)
	}
}
