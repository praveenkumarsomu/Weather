//
//  GalleryLocalAPITests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class GalleryLocalAPITests: XCTestCase {
	var galleryAPI: GalleryLocalAPI!
    override func setUpWithError() throws {
		galleryAPI = GalleryLocalAPI()
    }

    override func tearDownWithError() throws {
		galleryAPI = nil
	}
	
	func testGalleryLocal() async throws {
		// Act
		let data = try await galleryAPI.fetchImages()
		// Assert
		XCTAssertNotNil(data, "Data from the local image list file should not be nil")
		let resultObject = try JSONDecoder().decode(GalleryModel.Response.self, from: data)
		XCTAssertEqual(resultObject.images.count, 10, "resultObject images count should equal to number of images in gallery.json file")
		for (index, image) in resultObject.images.enumerated() {
			XCTAssertEqual(image.name, "image\(index+1)", "images in local file should start with image")
		}
	}

}
