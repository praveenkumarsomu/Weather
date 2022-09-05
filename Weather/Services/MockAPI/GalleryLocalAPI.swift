//
//  GalleryAPI.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation

class GalleryLocalAPI: GalleryStoreProtocol {
	func fetchImages() async throws -> Data {
		let constants = Constants()
		guard let filePath = Bundle.main.path(forResource: constants.galleryList, ofType: constants.json) else {
			throw GalleryAPIError.fileNotFound
		}
		let url = URL(fileURLWithPath: filePath)
		let content = try Data(contentsOf: url, options: .alwaysMapped)
		return content
	}
}
