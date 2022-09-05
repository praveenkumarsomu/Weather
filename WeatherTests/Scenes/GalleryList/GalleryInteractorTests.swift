//
//  GalleryInteractorTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class GalleryInteractorTests: XCTestCase {
	var interactor: GalleryInteractor!
	var worker: GalleryMockWorker!
	var presenter: GalleryMockPresenter!
    override func setUpWithError() throws {
		let store = GalleryLocalAPI()
		worker = GalleryMockWorker(store)
		interactor = GalleryInteractor(worker)
		presenter = GalleryMockPresenter()
		interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
		interactor = nil
		worker = nil
		presenter = nil
    }
	func testShouldFetchDataFromWorkerAndPassToPresenter() async {
		// Assign
		let request = GalleryModel.Request()
		// Act
		await interactor.getImages(request)
		// Assert
		XCTAssertTrue(self.worker.workerCalled, "Worker shoule be called from interactor")
		XCTAssertTrue(self.presenter.presenterCalled, "presenter shoule be called from interactor")
	}

}

class GalleryMockWorker: GalleryWorker {
	var workerCalled = false
	var workerCallback: (() -> Void)?
	override func fetchImages() async throws -> Data {
		workerCalled = true
		workerCallback?()
		return Data()
	}
}

class GalleryMockPresenter: GalleryPresentationLogic {
	var presenterCalled = false
	func presentGalleryImages(_ result: Result<GalleryModel.Response, GalleryAPIError>) {
		presenterCalled = true
	}
}
