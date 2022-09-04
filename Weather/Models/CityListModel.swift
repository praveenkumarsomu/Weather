//
//  CityListModel.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

/// City list model
enum CityListModel {
	/// As of now this struct is empty because we no need to pass anything to get city list from local json file. We can use this struct to add new request params if needed in future.
	struct Request { }
	/// Ciry list view response.
	struct Response: Codable {
		let cities: [City]
		struct City: Codable {
			let name: String
			let code: String
		}
		
	}
	/// City list view model to display data on `CityListViewController`.
	struct ViewModel {
		let cities: [City]
		struct City: Codable {
			let name: String
			let code: String
		}
	}
}
