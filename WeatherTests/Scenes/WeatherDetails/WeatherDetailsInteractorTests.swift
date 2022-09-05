//
//  WeatherDetailsInteractorTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class WeatherDetailsInteractorTests: XCTestCase {
	var interactor: WeatherDetailsInteractor!
	var worker: WeatherDetailsMockWorker!
	var presenter: WeatherDetailsMockPresenter!
    override func setUpWithError() throws {
		let dataStore = WeatherLocalAPI()
		worker = WeatherDetailsMockWorker(weatherStore: dataStore)
		interactor = WeatherDetailsInteractor(worker)
		presenter = WeatherDetailsMockPresenter()
		interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
		worker = nil
		interactor = nil
		presenter = nil
    }
	func testInteractorShouldCallWorkerAndUpdateResultToPresenter() async {
		// Assign
		let city = CityListModel.ViewModel.City(name: "Toronto", code: "CAON0696")
		let request = WeatherDetailsModel.Request(city: city, degree: "c")
		// Act
		await interactor.getWeatherDetails(request)
		// Assert
		XCTAssertTrue(self.worker.workerCalled, "Interactor failed to call worker")
		XCTAssertTrue(self.presenter.presenterCalled, "Interactor failed to update presenter")
	}
}

class WeatherDetailsMockWorker: WeatherDetailsWorker {
	var workerCalled = false
	var workerCallback: (() -> Void)?
	override func getWeatherDetails(for cityCode: String, degree: String) async throws -> Data {
		workerCalled = true
		workerCallback?()
		return Data()
	}
}

class WeatherDetailsMockPresenter: WeatherDetailsPresenterLogic {
	var presenterCalled = false
	func presentWeatherDetails(_ result: Result<WeatherDetailsModel.Response, WeatherAPIError>) {
		presenterCalled = true
	}
}
