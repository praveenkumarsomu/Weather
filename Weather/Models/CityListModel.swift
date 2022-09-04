//
//  CityListModel.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

enum CityListModel {
	struct Request { }
	struct Response: Codable {
		let cities: [City]
		struct City: Codable {
			let name: String
			let code: String
		}
		
	}
	struct ViewModel {
		let cities: [City]
		struct City: Codable {
			let name: String
			let code: String
		}
	}
}
