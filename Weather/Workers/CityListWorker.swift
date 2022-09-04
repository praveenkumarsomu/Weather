//
//  CityListWorker.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

protocol WeatherStoreProtocol {
	func fetchCityList() async throws -> Data
}
enum WeatherAPIError: Error {
	case fileNotFound
}
class CityListWorker {
	var citiesStore: WeatherStoreProtocol
	init(citiesStore: WeatherStoreProtocol) {
		self.citiesStore = citiesStore
	}
	/// Fetch data from the API
	/// As of now it just call function but in future if we want to extend functionality like off line support, etc we see more code from this function.
	/// - Returns: Returns city list data
	func fetchCityList() async throws -> Data {
		return try await citiesStore.fetchCityList()
	}
}
