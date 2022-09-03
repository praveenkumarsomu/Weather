//
//  CityListInteractorTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import XCTest
@testable import Weather

class CityListInteractorTests: XCTestCase {
	var interactor: CityListInteractor!
	var mockWorker: CityListMockWorker!
    override func setUpWithError() throws {
		mockWorker = CityListMockWorker(citiesStore: MockCityListAPI())
		interactor = CityListInteractor(worker: mockWorker)
    }
	func testFetchDataFromWorkerAndPassForPresentation() async {
		let mockPresenter = CityListMockPresenter()
		interactor.presenter = mockPresenter
		let request = CityListModel.Request()
		await interactor.getCityList(request)
		XCTAssertTrue(mockWorker.fetchCitiesCalled, "Interactor should call worker for city list data.")
		XCTAssertTrue(mockPresenter.presenterReceivedCallFromInteractor, "Presenter should receive call back from interactor after fetch cities api finishes.")
	}

}

class CityListMockPresenter: CityListPresentationLogic {
	var presenterReceivedCallFromInteractor = false
	func presentCityList(_ result: Result<CityListModel.Response, CityListModel.CityListError>) {
		presenterReceivedCallFromInteractor = true
	}
}
class CityListMockWorker: CityListWorker {
	var fetchCitiesCalled: Bool = false
	override func fetchCityList() throws -> Data {
		fetchCitiesCalled = true
		return try citiesStore.fetchCityList()
	}
}

class MockCityListAPI: CityListStoreProtocol {
	func fetchCityList() throws -> Data {
		let staticData = """
{
			"cities": [
			{
				"name": "Toronto",
				"code": "CAON0696"
			},
			{
				"name": "Montreal",
				"code": "CAON0423"
			},
			{
				"name": "Ottawa",
				"code": "CAON0512"
			},
			{
				"name": "Vancouver",
				"code": "CABC0308"
			},
			{
				"name": "Calgary",
				"code": "CAAB0049"
			}
			]
		}
"""
		guard let data = staticData.data(using: .utf8) else {
			throw CityStaticListAPI.DataError.fileNotFound
		}
		return data
	}
}
