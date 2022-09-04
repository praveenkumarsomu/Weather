//
//  WeatherDetailsModel.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

/// Weather details model, this enum contains Request, Response objects from the weather details API and View model to display data on `WeatherDetailsViewController`.
enum WeatherDetailsModel {
	struct Request {
		/// City object which we want to fetch the whether, this data is passed to `WeatherDetailsViewController` from `CityListViewController`.
		let city: CityListModel.ViewModel.City
		/// User can select in which degree he want to see the weathee details. We support Celsius and fahrenheit and corresponding values for them are `c`. and `f`.
		let degree: String
	}
	/// Full response object received from API call
	struct Response: Codable {
		let lastUpdateTimeLabel: String
		let updateTime: String
		let updateTimeStampGMT: String
		let weatherCondition: String
		let icon, inic: String
		@Temparature var temperature: String
		@Temparature var feelsLike: String
		let temperatureUnit, placeCode: String
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
	/// We are getting `	temparature`  and `feelsLike` values as` String` and `Int`.  Below property wrapper resolves the coresponding value types successfully.
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
	/// View model object to display weather details on `WeatherDetailsViewController`.
	struct ViewModel {
		/// `cityName` was local variable not return from API. On the `WeatherDetailsViewController` we need to display city name which is not part of API response. This value will be assigned in controller `WeatherDetailsViewController`  while displaying API response on screen.
		var cityName: String?
		let lastUpdatedLabel: String
		let lastUpdatedTime: String
		let weatherCondition: String
		let temparature: String
		let feelsLike: String
		let temparatureUnit: String
	}
}
