//
//  GalleryPresenter.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation

/// Gallery presentation logic.
protocol GalleryPresentationLogic {
	/// Present response from interactor to `GalleryViewController`.
	/// - Parameter result: response object
	func presentGalleryImages(_ result: Result<GalleryModel.Response, GalleryAPIError>)
}
extension GalleryPresentationLogic {
	/// Convert response object into view model
	/// - Parameter response: response object
	/// - Returns: view model object
	func convertResponseToViewModel(_ response: GalleryModel.Response) -> GalleryModel.ViewModel {
		let listOfImageNames: [String] = response.images.map { imageObject in
			return imageObject.name
		}
		return GalleryModel.ViewModel(images: listOfImageNames)
	}
}

/// Gallery list presenter implementation.
class GalleryPresenter: GalleryPresentationLogic {
	/// `GalleryViewController` implements `GalleryDisplayLogic` protocol to consume presenter output.
	var view: GalleryDisplayLogic!
	func presentGalleryImages(_ result: Result<GalleryModel.Response, GalleryAPIError>) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				let viewModel = self.convertResponseToViewModel(response)
				self.view.displayImages(viewModel)
			case .failure(let error):
				self.view.displayErrorOnFailure(error)
			}
		}
	}
}
