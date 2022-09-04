//
//  CityListInteractor.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

protocol CityListViewBusinessLogic {
	func getCityList(_ request: CityListModel.Request) async
}

/// This file contains all the business logic related to City list
/// This takes input from view controller `CityListViewController` and passback data to presenter `CityListPresenter`
class CityListInteractor: CityListViewBusinessLogic {
	/// Presenter protocol
	var presenter: CityListPresentationLogic!
	/// Worker file to execute API to get list of cities, as of now it loads data from the local json file from the bundle. We can easily replace this with API call with new implementation of the protocol `CityListWorker` no extra changes required in any of the other files.
	var cityListWorker: WeatherDetailsWorker
	init (worker: WeatherDetailsWorker = WeatherDetailsWorker(weatherStore: WeatherLocalAPI())) {
		self.cityListWorker = worker
	}
	/// Get city from the worker and pass back status to presenter.
	/// - Parameter request: Request is astructure that contains information to fetch city list from API, as of now it is empty struct but in future if we want to add more functionality it is used. Example for additional functionality is sorting or filtering inputs from user.
	func getCityList(_ request: CityListModel.Request) async {
		do {
			let cityListData = try await cityListWorker.fetchCityList()
			let cityList = try JSONDecoder().decode(CityListModel.Response.self, from: cityListData)
			presenter.presentCityList(.success(cityList))
		} catch {
			presenter.presentCityList(.failure(.cityListNotFound))
		}
	}
}
