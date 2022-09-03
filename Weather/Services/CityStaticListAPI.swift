//
//  CityStaticListAPI.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

/// Fetch list of cities from the local json file
class CityStaticListAPI: CityListStoreProtocol {
	enum DataError: Error {
		case fileNotFound
	}
	
	func fetchCityList() throws -> Data {
		let constants = Constants()
		guard let filePath = Bundle.main.path(forResource: constants.cityListFileName, ofType: constants.cityListFileExtension) else {
			throw DataError.fileNotFound
		}
		let url = URL(fileURLWithPath: filePath)
		let content = try Data(contentsOf: url, options: .alwaysMapped)
		return content
	}
}
