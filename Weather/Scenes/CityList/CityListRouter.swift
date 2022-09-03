//
//  CityListRouter.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import Foundation
import UIKit

/// This is protocol to handle navigation from `CityListViewController`
protocol CityListRouterProtocol {
	/// Displays error message on controller on API failure
	func displayErrorMessageOnCityListAPIFailure(_ error: CityListModel.CityListError)
	/// Naviogates user to contact us screen
	func navigateToContactScreen()
	/// Navigates user to Gallery screen
	func navigateToGalleryScreen()
}
protocol CityListOrdersDataPassing {
}
class CityListRouter: CityListRouterProtocol, CityListOrdersDataPassing {
	weak var viewController: CityListViewController?
	func displayErrorMessageOnCityListAPIFailure(_ error: CityListModel.CityListError) {
		let constants = Constants()
		let alertController = UIAlertController(title: constants.error, message: constants.cityListAPIFailureMessage, preferredStyle: .alert)
		let okAction = UIAlertAction(title: constants.okayButtonTitle, style: .destructive)
		alertController.addAction(okAction)
		viewController?.present(alertController, animated: true)
	}
	func navigateToContactScreen() {
		
	}
	func navigateToGalleryScreen() {
		
	}
}
