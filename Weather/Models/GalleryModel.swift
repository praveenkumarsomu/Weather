//
//  GalleryModel.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation

/// Gallery model
enum GalleryModel {
	/// As of now `Request` object is empty because we displaying local images from Asset catalog, in future if we need to fetch image from API call we add request parameters here.
	struct Request { }
	/// Response object
	struct Response: Codable {
		let images: [Image]
		struct Image: Codable {
			let name: String
		}
	}
	/// View model to display imgaes on `GalleryViewController`.
	struct ViewModel: Equatable {
		let images: [String]
	}
}
