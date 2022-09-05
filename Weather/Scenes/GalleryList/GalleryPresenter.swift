//
//  GalleryPresenter.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation

protocol GalleryPresentationLogic {
	func presentGalleryImages(_ result: Result<GalleryModel.Response, GalleryAPIError>)
}
extension GalleryPresentationLogic {
	func convertResponseToViewModel(_ response: GalleryModel.Response) -> GalleryModel.ViewModel {
		let listOfImageNames: [String] = response.images.map { imageObject in
			return imageObject.name
		}
		return GalleryModel.ViewModel(images: listOfImageNames)
	}
}

class GalleryPresenter: GalleryPresentationLogic {
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
