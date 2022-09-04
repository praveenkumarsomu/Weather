//
//  WeatherDetailsPresenterTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class WeatherDetailsPresenterTests: XCTestCase {
	var presenter: WeatherDetailsPresenter!
	var view: WeatherDetailsMockController!
    override func setUpWithError() throws {
        presenter = WeatherDetailsPresenter()
		view = WeatherDetailsMockController()
		presenter.view = view
    }
    override func tearDownWithError() throws {
		presenter = nil
    }
	func testPresenterCallBackToViewControllerOnSuccess() {
		// Assign
		let response = WeatherDetailsModel.Response(lastUpdateTimeLabel: "Updated on", updateTime: "Sun Sep 4 2:45 PM", updateTimeStampGMT: "1662317100000", weatherCondition: "Light drizzle", icon: "9", inic: "iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAMAAADzjKfhAAAANlBMVEUAAABcmsry8/Numb1Wk8S2vcTc3d5UksPW2dzW19i7xtFvl7vk5eefssNZhavZ2tzF0Nm6xtFu2WdcAAAAEHRSTlMADPu/anZ0Vj8p7K2fWCgPchRtPgAAADBJREFUCNcVxskBACAIxMAFUcQT+29WmE+CYIbUmduNLI5BHe7PK3YJ84BURJQASvgcTAD8Y3WcUAAAAABJRU5ErkJggg==", temperature: "17", feelsLike: "16", temperatureUnit: "C", placeCode: "CAON0696")
		let expectation = expectation(description: "Presenter should update view")
		view.callBack = {
			// Assert
			XCTAssertTrue(self.view.successCallbackCalled, "Presenter should update API response back to view controller")
			expectation.fulfill()
		}
		// Act
		self.presenter.presentWeatherDetails(.success(response))
		waitForExpectations(timeout: 3.0)
	}
	func testPresenterCallBackToViewControllerOnFailure() {
		let expectation = expectation(description: "Presenter should update view")
		view.callBack = {
			// Assert
			XCTAssertTrue(self.view.failureCallbackCalled, "Presenter should update API response back to view controller")
			expectation.fulfill()
		}
		// Act
		presenter.presentWeatherDetails(.failure(.genericError))
		waitForExpectations(timeout: 3.0)
	}
	func testResponseToViewModelConversion() {
		// Assign
		let response = WeatherDetailsModel.Response(lastUpdateTimeLabel: "Updated on", updateTime: "Sun Sep 4 2:45 PM", updateTimeStampGMT: "1662317100000", weatherCondition: "Light drizzle", icon: "9", inic: "iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAMAAADzjKfhAAAANlBMVEUAAABcmsry8/Numb1Wk8S2vcTc3d5UksPW2dzW19i7xtFvl7vk5eefssNZhavZ2tzF0Nm6xtFu2WdcAAAAEHRSTlMADPu/anZ0Vj8p7K2fWCgPchRtPgAAADBJREFUCNcVxskBACAIxMAFUcQT+29WmE+CYIbUmduNLI5BHe7PK3YJ84BURJQASvgcTAD8Y3WcUAAAAABJRU5ErkJggg==", temperature: "17", feelsLike: "16", temperatureUnit: "C", placeCode: "CAON0696")
		// Act
		let viewModel = presenter.convertResponseModelIntoViewModel(response)
		// Assert
		XCTAssertEqual(viewModel.weatherCondition, response.weatherCondition, "view model weatherCondition value should be equal to response weatherCondition value")
		XCTAssertEqual(viewModel.temparatureUnit, response.temperatureUnit, "view model temparatureUnit value should be equal to response temparatureUnit value")
		XCTAssertEqual(viewModel.temparature, response.temperature, "view model temparature value should be equal to response temparature value")
		XCTAssertEqual(viewModel.feelsLike, response.feelsLike, "view model fellsLike value should be equal to response fellsLike value")
		XCTAssertEqual(viewModel.lastUpdatedLabel, response.lastUpdateTimeLabel, "view model lastUpdatedLabel value should be equal to response lastUpdateTimeLabel value")
		XCTAssertEqual(viewModel.lastUpdatedTime, response.updateTime, "view model lastUpdatedTime value should be equal to response updateTime value")
	}
}
class WeatherDetailsMockController: WeatherDetailsDisplayLogic {
	var callBack: (() -> Void)?
	var successCallbackCalled = false
	var failureCallbackCalled = false
	func displayWeatherDetails(_ viewModel: WeatherDetailsModel.ViewModel) {
		successCallbackCalled = true
		callBack?()
	}
	
	func displayWeatherDetailsError() {
		failureCallbackCalled = true
		callBack?()
	}
	
}
