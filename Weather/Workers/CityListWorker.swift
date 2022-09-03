//
//  CityListWorker.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

protocol CityListStoreProtocol {
	func fetchCityList() throws -> Data
}

class CityListWorker {
	var citiesStore: CityListStoreProtocol
	init(citiesStore: CityListStoreProtocol) {
		self.citiesStore = citiesStore
	}
}
