//
//  GalleryAPI.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation

/// This calss is place holder class when we want to download images from remote server, add API call inside `fetchImages` function and use this class when constructing `GalleryWorker` object inside `GalleryViewController`.
class GalleryAPI: GalleryStoreProtocol {
	func fetchImages() async throws -> Data {
		return Data()
	}
}
