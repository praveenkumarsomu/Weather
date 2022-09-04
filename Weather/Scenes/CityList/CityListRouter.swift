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
}
protocol CityListOrdersDataPassing {
}
class CityListRouter: CityListRouterProtocol, CityListOrdersDataPassing {
	weak var viewController: CityListViewController?
	func navigateToContactScreen() {
		let contactUsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ContactUsViewController.self))
		viewController?.navigationController?.pushViewController(contactUsVC, animated: true)
	}
	func navigateToGalleryScreen() {
		
	}
}
