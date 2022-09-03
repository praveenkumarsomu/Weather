//
//  CityListInteractor.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

protocol CityListViewBusinessLogic {
	func getCityList() async
}

/// This file contains all the business logic related to City list
/// This takes input from view controller `CityListViewController` and passback data to presenter `CityListPresenter`
class CityListInteractor: CityListViewBusinessLogic {
	/// Presenter protocol
	var presenter: CityListPresentationLogic!
	/// Worker file to execute API to get list of cities, as of now it loads data from the local json file from the bundle. We can easily replace this with API call with new implementation of the protocol `CityListWorker` no extra changes required in any of the other files.
	var cityListWorker: CityListWorker
	init (worker: CityListWorker = CityListWorker(citiesStore: CityStaticListAPI())) {
		self.cityListWorker = worker
	}
	/// Get city from the worker and pass back status to presenter.
	func getCityList() async {
		do {
			let cityListData = try cityListWorker.citiesStore.fetchCityList()
			let cityList = try JSONDecoder().decode(CityListModel.Response.self, from: cityListData)
			presenter.presentCityList(.success(cityList))
		} catch {
			presenter.presentCityList(.failure(.failedToFetchCities))
		}
	}
}
