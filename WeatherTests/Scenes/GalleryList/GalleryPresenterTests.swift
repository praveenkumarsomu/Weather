//
//  GalleryPresenterTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class GalleryPresenterTests: XCTestCase {
	var presenter: GalleryPresenter!
	var view: GalleryMockController!
    override func setUpWithError() throws {
		presenter = GalleryPresenter()
		view = GalleryMockController()
		presenter.view = view
    }

    override func tearDownWithError() throws {
		presenter = nil
		view = nil
    }
	func testSuccessCallback() {
		// Assign
		let image = GalleryModel.Response.Image(name: "image")
		let response = GalleryModel.Response(images: [image])
		let viewModel = presenter.convertResponseToViewModel(response)
		// Act
		presenter.presentGalleryImages(.success(response))
		let expectation = expectation(description: "Presenter to view callbacks")
		view.callBack = {
			// Assert
			XCTAssertTrue(self.view.isSuccessCallbackCalled, "Presenter should call view to display images")
			XCTAssertEqual(viewModel, self.view.viewModel, "Presenter should convert response into view model before passing it to view")
			expectation.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}

}

class GalleryMockController: GalleryDisplayLogic {
	var viewModel: GalleryModel.ViewModel?
	var isSuccessCallbackCalled = false
	var isErrorCallbackCalled = false
	var callBack: (() -> Void)?
	func displayImages(_ viewModel: GalleryModel.ViewModel) {
		self.viewModel = viewModel
		isSuccessCallbackCalled = true
		callBack?()
	}
	
	func displayErrorOnFailure(_ error: GalleryAPIError) {
		isErrorCallbackCalled = true
		callBack?()
	}
}
