//
//  CityListPresenter.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation

protocol CityListPresentationLogic {
	func presentCityList(_ result: Result<CityListModel.Response, CityListModel.CityListError>)
}
extension CityListPresentationLogic {
	func convertResponseIntoViewModel(_ response: CityListModel.Response) -> CityListModel.ViewModel {
		let cities: [CityListModel.ViewModel.City] = response.cities.map { city in
			return CityListModel.ViewModel.City(name: city.name, code: city.code)
		}
		return CityListModel.ViewModel(cities: cities)
	}
}
/// Presenter accepts the status of the get city list API and process data to display in view controller `CityListViewController`.
class CityListPresenter: CityListPresentationLogic {
	weak var view: CityListDisplayLogic!
	/// Receive data from the interactor `CityListInteractor` and processes the data and passbacks the view model to `CityListViewController`.
	/// - Parameter result: API result from interactor.
	func presentCityList(_ result: Result<CityListModel.Response, CityListModel.CityListError>) {
		DispatchQueue.main.async { [weak self] in
			guard let self =  self else { return }
			switch result {
			case .success(let cityList):
				let viewModel = self.convertResponseIntoViewModel(cityList)
				self.view.displayCityList(viewModel)
			case .failure(let error):
				self.view.displayErrorWhileFetchingCityList(error)
			}
		}
	}
}
