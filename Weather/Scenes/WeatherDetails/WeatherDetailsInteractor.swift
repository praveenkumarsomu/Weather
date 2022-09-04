//
//  WeatherDetailsInteractor.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

/// Weather details business logic
protocol WeatherDetailsBusinessLogic {
	/// Get weather details of the selected city.
	/// - Parameter request: selected city object.
	func getWeatherDetails(_ request: WeatherDetailsModel.Request) async throws
}

class WeatherDetailsInteractor: WeatherDetailsBusinessLogic {
	let worker: WeatherDetailsWorker
	var presenter: WeatherDetailsPresenterLogic!
	init(_ worker: WeatherDetailsWorker) {
		self.worker = worker
	}
	func getWeatherDetails(_ request: WeatherDetailsModel.Request) async throws {
		let weatherDetailsData = try await worker.getWeatherDetails(for: request.city.code, degree: request.degree)
		do {
			let response = try JSONDecoder().decode(WeatherDetailsModel.Response.self, from: weatherDetailsData)
			presenter.presentWeatherDetails(.success(response))
		} catch let error where error is WeatherAPIError {
			// We can resolve error by specifying each type in seperate catch block here. As we displaying generic errors for now choose to force unwrap error value below. It will be safe as we checking whether error is `WeatherAPIError` type or not above.
			presenter.presentWeatherDetails(.failure(error as! WeatherAPIError))
		} catch {
			// It is just a fallback normally never get called.
			presenter.presentWeatherDetails(.failure(WeatherAPIError.genericError))
		}
	}
}
