//
//  GalleryWorker.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import Foundation

/// Gallery API Implementation protocol.
protocol GalleryStoreProtocol {
	func fetchImages() async throws -> Data
}

/// Gallery worker implementation
/// This is used in ``
class GalleryWorker {
	let dataStore: GalleryStoreProtocol
	init(_ store: GalleryStoreProtocol) {
		self.dataStore = store
	}
	func fetchImages() async throws -> Data {
		return try await dataStore.fetchImages()
	}
}

enum GalleryAPIError: Error {
	case genericError
	case invalidData
	case fileNotFound
}
