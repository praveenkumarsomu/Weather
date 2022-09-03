//
//  CityListPresenterTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import XCTest
@testable import Weather

class CityListPresenterTests: XCTestCase {
	var presenter: CityListPresenter!
    override func setUpWithError() throws {
		presenter = CityListPresenter()
    }
	func testDisplayLogicCallbackIncaseOfSuccess() {
		let mockController = CityListMockController()
		presenter.view = mockController
		let mockCityList = CityListMockResponse().getResponse()
		let expection = expectation(description: "Presenter async update")
		presenter.presentCityList(.success(mockCityList))
		mockController.callBackTriggerCompletion = {
			XCTAssertTrue(mockController.diaplayLogicCalled, "In case of success presenter should inform controller to display error.")
			expection.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
	func testDisplayLogicCallbackInCaseOfFailure() {
		let mockController = CityListMockController()
		presenter.view = mockController
		let expection = expectation(description: "Presenter async update")
		presenter.presentCityList(.failure(.failedToFetchCities))
		mockController.callBackTriggerCompletion = {
			XCTAssertTrue(mockController.diaplayLogicCalled, "In case of error presenter should inform controller to display error.")
			expection.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
	func testViewModelConvertion() {
		let mockController = CityListMockController()
		presenter.view = mockController
		let mockCityList = CityListMockResponse().getResponse()
		let expection = expectation(description: "Presenter async update")
		presenter.presentCityList(.success(mockCityList))
		mockController.callBackTriggerCompletion = {
			mockController.displayedCities.cities.forEach { city in
				XCTAssertEqual(city.name, "Toronto", "Presenter should convert Response from API to View model with out any data loass or corruption")
				XCTAssertEqual(city.code, "CAON0696", "Presenter should convert Response from API to View model with out any data loass or corruption")
			}
			expection.fulfill()
		}
		
		waitForExpectations(timeout: 3.0)
	}
}
//MARK: Mock View controller display logic
class CityListMockController: CityListDisplayLogic {
	var diaplayLogicCalled = false
	var displayedCities: CityListModel.ViewModel!
	var callBackTriggerCompletion: (() -> Void)?
	func displayCityList(_ cities: CityListModel.ViewModel) {
		diaplayLogicCalled = true
		displayedCities = cities
		callBackTriggerCompletion?()
	}
	func displayErrorWhileFetchingCityList(_ error: CityListModel.CityListError) {
		diaplayLogicCalled = true
		callBackTriggerCompletion?()
	}
}

//MARK: Mock Response
class CityListMockResponse {
	func getResponse() -> CityListModel.Response {
		let cities = CityListModel.Response.City(name: "Toronto", code: "CAON0696")
		let response = CityListModel.Response(cities: [cities])
		return response
	}
}
