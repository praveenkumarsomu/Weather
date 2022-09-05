//
//  GalleryRouter.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation
import UIKit

/// Router protocol for `GalleryViewController`
protocol GalleryRouterProtocol {
	func displayFullSizeImage(_ imageName: String) throws
}

/// Router implementation for `GalleryViewController`
class GalleryRouter: GalleryRouterProtocol {
	/// Router holds the weak reference of the controller.
	weak var controller: GalleryViewController!
	/// Navigate to `DisplayImageViewController`
	/// - Parameter imageName: image needs to be displayed
	func displayFullSizeImage(_ imageName: String) throws {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		guard let imageController = storyBoard.instantiateViewController(withIdentifier: String(describing: DisplayImageViewController.self)) as? DisplayImageViewController else {
			throw GalleryRouterError.imageDisplayControllerNotFound
		}
		imageController.imageName = imageName
		controller.navigationController?.pushViewController(imageController, animated: true)
	}
}
/// Router custom error implementation.
enum GalleryRouterError: Error {
	case imageDisplayControllerNotFound
}
