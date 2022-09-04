//
//  WeatherDetailsModel.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

enum WeatherDetailsModel {
	struct Request {
		let city: CityListModel.ViewModel.City
		let degree: String
	}
	struct Response: Codable {
		let lastUpdateTimeLabel: String
		let updateTime: String
		let updateTimeStampGMT: String
		let weatherCondition: String
		let icon, inic: String
		@Temparature var temperature: String
		@Temparature var feelsLike: String
		let temperatureUnit, placeCode: String
		/// This was local variable not return from API
		var cityName: String?
		enum CodingKeys: String, CodingKey {
			case lastUpdateTimeLabel = "lbl_updatetime"
			case updateTime = "updatetime"
			case updateTimeStampGMT = "updatetime_stamp_gmt"
			case weatherCondition = "wxcondition"
			case icon, inic, temperature
			case feelsLike = "feels_like"
			case temperatureUnit = "temperature_unit"
			case placeCode = "placecode"
		}
	}
	@propertyWrapper
	struct Temparature: Codable {

		var wrappedValue: String
		init(wrappedValue: String) {
			self.wrappedValue = wrappedValue
		}

		public init(from decoder: Decoder) throws {
			do {
				wrappedValue = try decoder.singleValueContainer().decode(String.self)
			} catch DecodingError.typeMismatch {
				let intValue = try decoder.singleValueContainer().decode(Int.self)
				wrappedValue = "\(intValue)"
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			try container.encode(wrappedValue)
		}
	}
	struct ViewModel {
		let cityName: String?
		let lastUpdatedLabel: String
		let lastUpdatedTime: String
		let weatherCondition: String
		let temparature: String
		let feelsLike: String
		let temparatureUnit: String
	}
}
