//
//  GalleryRouter.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation
import UIKit

protocol GalleryRouterProtocol {
	func displayFullSizeImage(_ imageName: String) throws
}

class GalleryRouter: GalleryRouterProtocol {
	weak var controller: GalleryViewController!
	func displayFullSizeImage(_ imageName: String) throws {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		guard let imageController = storyBoard.instantiateViewController(withIdentifier: String(describing: DisplayImageViewController.self)) as? DisplayImageViewController else {
			throw GalleryRouterError.imageDisplayControllerNotFound
			return
		}
		imageController.imageName = imageName
		controller.navigationController?.pushViewController(imageController, animated: true)
	}
}
enum GalleryRouterError: Error {
	case imageDisplayControllerNotFound
}
