//
//  GalleryInteractor.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation

/// Gallery business logic
protocol GalleryBusinessLogic {
	func getImages(_ request: GalleryModel.Request) async
}

class GalleryInteractor: GalleryBusinessLogic {
	let worker: GalleryWorker
	/// Presentation implementation, once we receive images data from worker we pass it to presenter to display on view.
	var presenter: GalleryPresentationLogic!
	init(_ worker: GalleryWorker) {
		self.worker = worker
	}
	func getImages(_ request: GalleryModel.Request) async {
		do {
			let imagesData = try await worker.fetchImages()
			let response = try JSONDecoder().decode(GalleryModel.Response.self, from: imagesData)
			presenter.presentGalleryImages(.success(response))
		} catch {
			/// As of now we doing generic error for all type of errors we can improve this in future if needed
			presenter.presentGalleryImages(.failure(.invalidData))
		}
	}
}
