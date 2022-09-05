//
//  GalleryControllerTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class GalleryControllerTests: XCTestCase {
	var controller: GalleryViewController!
	var interactor: GalleryMockInteractor!
    override func setUpWithError() throws {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		guard let viewController = storyBoard.instantiateViewController(withIdentifier: String(describing: GalleryViewController.self)) as? GalleryViewController else {
			XCTFail("Unable to instantiate GalleryViewController")
			return
		}
		controller = viewController
    }

    override func tearDownWithError() throws {
		controller = nil
		interactor = nil
    }
	func loadView() {
		controller.beginAppearanceTransition(true, animated: true)
	}
	func testControllerConfiguration() {
		// Act
		loadView()
		// Assert
		XCTAssertNotNil(controller.interactor, "Interactor should instantiate on loading controller from nib")
	}
	func testShouldTriggerInteractorToGetImagesOnViewDidLoad() {
		// Assign
		interactor = GalleryMockInteractor()
		controller.interactor = interactor
		// Act
		loadView()
		let expectation = expectation(description: "Controller should trigger interactor")
		interactor.interactorCallBack = {
			// Assert
			XCTAssertTrue(self.interactor.interactorCalled, "On view did load controller should call interactor for list of images")
			expectation.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
	func testNumberOfSectionsInCollectionView() {
		//Act
		loadView()
		// Assert
		XCTAssertEqual(controller.collectionView.numberOfSections, 1, "collection view should display one section")
	}
	func testNumberOfRowsInCollectionView() {
		// Assign
		let images = ["image1", "image2", "image3", "image4", "image5", "image6"]
		controller.displayedImages = images
		// Act
		loadView()
		// Assert
		XCTAssertEqual(controller.collectionView.numberOfItems(inSection: 0), images.count, "collection view rows count should equal to displayedImages count")
	}
	func testNumberOfRowsInCollectionViewIfImageCountIsgreaterThanTen() {
		// Assign
		let images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11"]
		controller.displayedImages = images
		// Act
		loadView()
		// Assert
		XCTAssertEqual(controller.collectionView.numberOfItems(inSection: 0), 10, "collection view rows should be less than or equal to ten")
	}
	func testRouterCallBack() {
		// Assign
		let images = ["image1", "image2", "image3", "image4", "image5", "image6"]
		controller.displayedImages = images
		let router = GalleryMockrouter()
		controller.router = router
		// Act
		loadView()
		controller.collectionView(controller.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
		// Assert
		XCTAssertEqual(router.imageName, images.first, "Controller should pass correct image name to router")
	}
}

class GalleryMockInteractor: GalleryBusinessLogic {
	var interactorCalled = false
	var interactorCallBack: (() -> Void)?
	func getImages(_ request: GalleryModel.Request) async {
		interactorCalled = true
		interactorCallBack?()
	}
	
}
class GalleryMockrouter: GalleryRouterProtocol {
	var imageName: String?
	func displayFullSizeImage(_ imageName: String) throws {
		self.imageName = imageName
	}
}
