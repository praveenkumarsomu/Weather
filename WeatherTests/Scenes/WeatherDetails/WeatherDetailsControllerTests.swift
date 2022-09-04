//
//  WeatherDetailsControllerTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class WeatherDetailsControllerTests: XCTestCase {
	var controller: WeatherDetailsViewController!
    override func setUpWithError() throws {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		guard let controller = storyBoard.instantiateViewController(withIdentifier: String(describing: WeatherDetailsViewController.self)) as? WeatherDetailsViewController else {
			XCTFail("unable to construct WeatherDetailsViewController")
			return
		}
		self.controller = controller
		controller.city = CityListModel.ViewModel.City(name: "Toronto", code: "CAON0696")
    }

    override func tearDownWithError() throws {
		controller = nil
    }
	func loadView() {
		controller.beginAppearanceTransition(true, animated: true)
	}
	func testInteractorCallOnViewDidLoad() {
		// Assign
		let mockIntractor = WeatherDetailsMockInteractor()
		controller.interactor = mockIntractor
		// Act
		let expectation = expectation(description: "Interactor call on view did load")
		loadView()
		// Assert
		mockIntractor.interactorCallback = {
			XCTAssertTrue(mockIntractor.interactorCalled, "On view did load view will call interactor to fetch weather details")
			XCTAssertEqual(mockIntractor.request?.city.code, self.controller.city.code, "Controller should pass the city code to interactor")
			expectation.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
	func testDegreeSelections() {
		// Assign
		let mockIntractor = WeatherDetailsMockInteractor()
		controller.interactor = mockIntractor
		// Act
		let expectation = expectation(description: "Degree selection")
		//loadView()
		controller.degree = .fahrenheit
		// Assert
		mockIntractor.interactorCallback = {
			XCTAssertEqual(mockIntractor.request?.degree, "f", "Controller should pass the city code to interactor")
			expectation.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
	func testTableViewSections() {
		// Act
		loadView()
		// Assert
		XCTAssertEqual(controller.tableView.numberOfSections, 1, "Weather details controller table view should have one section")
	}
	func testTableViewRowsWhenViewModelIsNil() {
		// Act
		loadView()
		// Assert
		XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 0, "Weather details controller table view should have zero rows in section in case of empty view model")
	}
	func testTableViewRowsWhenViewModelIsNotNil() {
		// Assign
		let viewModel = WeatherDetailsModel.ViewModel(cityName: "Toronto", lastUpdatedLabel: "Updated on", lastUpdatedTime: "Sun Sep 4 12:15 PM", weatherCondition: "Overcast", temparature: "16", feelsLike: "16", temparatureUnit: "C")
		controller.displayedWeatherDetails = viewModel
		// Act
		loadView()
		// Assert
		XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 1, "Weather details controller table view should have one row in section in case of view model not nil")
	}
	func testTableViewCellConfiguration() {
		// Assign
		let constants = Constants()
		loadView()
		let viewModel = WeatherDetailsModel.ViewModel(cityName: "Toronto", lastUpdatedLabel: "Updated on", lastUpdatedTime: "Sun Sep 4 12:15 PM", weatherCondition: "Overcast", temparature: "16", feelsLike: "16", temparatureUnit: "C")
		controller.displayedWeatherDetails = viewModel
		// Act
		controller.tableView.reloadData()
		guard let cell = controller.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? WeatherDetailsTableViewCell else {
			XCTFail("Not able to construct WeatherDetailsTableViewCell")
			return
		}
		// Assert
		XCTAssertEqual(cell.countryNameLabel.text, viewModel.cityName, "City name should be displayed")
		XCTAssertEqual(cell.lastUpdatedOnLabel.text, "\(viewModel.lastUpdatedLabel) \(viewModel.lastUpdatedTime)", "Last update on label displayed data is fault")
		XCTAssertEqual(cell.lastUpdatedOnLabel.text, "\(viewModel.lastUpdatedLabel) \(viewModel.lastUpdatedTime)", "Last update on label displayed data is fault")
		XCTAssertEqual(cell.temparatureLabel.text, "\(constants.currentTemparatureIs) \(viewModel.temparature) \(viewModel.temparatureUnit)", "Temparatire label displayed data is fault")
		XCTAssertEqual(cell.conditionLabel.text, "\(constants.weatherCondition) \(viewModel.weatherCondition)", "Condition label displayed data is fault")
		XCTAssertEqual(cell.feelsLikeLabel.text, "\(constants.itFeelsLike) \(viewModel.feelsLike) \(viewModel.temparatureUnit)", "Fells like label displayed data is fault")
	}
}

class WeatherDetailsMockInteractor: WeatherDetailsBusinessLogic {
	var interactorCalled = false
	var interactorCallback: (() -> Void)?
	var request: WeatherDetailsModel.Request?
	func getWeatherDetails(_ request: WeatherDetailsModel.Request) async throws {
		interactorCalled = true
		self.request = request
		interactorCallback?()
	}
}
