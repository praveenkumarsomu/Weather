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
	/// Naviogates user to contact us screen
	func navigateToContactScreen()
	/// Navigates user to Gallery screen
	func navigateToGalleryScreen()
	/// Display weather details for the selected city. This function was called on table view cell selection from `CityListViewController`.
	/// - Parameter city: selected city object
	func displayWeatherDetails(for city: CityListModel.ViewModel.City) throws
}

class CityListRouter: CityListRouterProtocol {
	enum RouterError: Error {
		case weatherDetailsVCNotFound
	}
	weak var viewController: CityListViewController?
	func navigateToContactScreen() {
		let contactUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ContactUsViewController.self))
		viewController?.navigationController?.pushViewController(contactUsVC, animated: true)
	}
	func navigateToGalleryScreen() {
		
	}
	func displayWeatherDetails(for city: CityListModel.ViewModel.City) throws {
		guard let weatherDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: WeatherDetailsViewController.self)) as? WeatherDetailsViewController else {
			throw RouterError.weatherDetailsVCNotFound
		}
		weatherDetailsVC.city = city
		viewController?.navigationController?.pushViewController(weatherDetailsVC, animated: true)
	}
}
