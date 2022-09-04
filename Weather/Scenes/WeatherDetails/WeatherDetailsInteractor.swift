//
//  WeatherDetailsInteractor.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

protocol WeatherDetailsBusinessLogic {
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
			var response = try JSONDecoder().decode(WeatherDetailsModel.Response.self, from: weatherDetailsData)
			response.cityName = request.city.name
			presenter.presentWeatherDetails(.success(response))
		} catch let error where error is WeatherAPIError {
			presenter.presentWeatherDetails(.failure(error as! WeatherAPIError))
		} catch {
			print(error)
			presenter.presentWeatherDetails(.failure(WeatherAPIError.genericError))
		}
	}
}
