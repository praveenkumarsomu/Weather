//
//  WeatherDetailsPresenter.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

/// Weather details presentation logic
protocol WeatherDetailsPresenterLogic {
	/// Present the weather details API result received from interactor and display data on `WeatherDetailsViewController`.
	/// - Parameter result: result object from interactor `WeatherDetailsInteractor`.
	func presentWeatherDetails(_ result: Result<WeatherDetailsModel.Response, WeatherAPIError>)
}
extension WeatherDetailsPresenterLogic {
	/// Convert API response model into view model.
	/// - Parameter response: response object received from weather details API
	/// - Returns: returns view model object.
	func convertResponseModelIntoViewModel(_ response: WeatherDetailsModel.Response) -> WeatherDetailsModel.ViewModel {
		let viewModel = WeatherDetailsModel.ViewModel(lastUpdatedLabel: response.lastUpdateTimeLabel, lastUpdatedTime: response.updateTime, weatherCondition: response.weatherCondition, temparature: response.temperature, feelsLike: response.feelsLike, temparatureUnit: response.temperatureUnit)
		return viewModel
	}
}

class WeatherDetailsPresenter: WeatherDetailsPresenterLogic {
	weak var view: WeatherDetailsDisplayLogic!
	func presentWeatherDetails(_ result: Result<WeatherDetailsModel.Response, WeatherAPIError>) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				let viewModel = self.convertResponseModelIntoViewModel(response)
				self.view.displayWeatherDetails(viewModel)
			case .failure:
				self.view.displayWeatherDetailsError()
			}
		}
	}
}
