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
		mockWorker = CityListMockWorker(weatherStore: MockCityListAPI())
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
	func presentCityList(_ result: Result<CityListModel.Response, WeatherAPIError>) {
		presenterReceivedCallFromInteractor = true
	}
}
class CityListMockWorker: WeatherDetailsWorker {
	var fetchCitiesCalled: Bool = false
	override func fetchCityList() async throws -> Data {
		fetchCitiesCalled = true
		return try await weatherStore.fetchCityList()
	}
}

class MockCityListAPI: WeatherStoreProtocol {
	func getWeatherDetails(_ url: URL) async throws -> Data {
		let staticData =
  """
  {
  "lbl_updatetime": "Updated on",
  "updatetime": "Sun Sep 4 12:15 PM",
  "updatetime_stamp_gmt": "1662308100000",
  "wxcondition": "Overcast",
  "icon": "8",
  "inic": "iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAMAAADzjKfhAAAAOVBMVEUAAACqrK3Excfz8/PGyMnf4OHExcfb293x8fLc3t/Ly868vsDp6uvNzdDl5efY2drs7O309fbj4+SFqsRJAAAAEHRSTlMAFsDz018rGOy8pHx7SzIJpLZtPQAAAC9JREFUCNc1wYcRACAIBLAXFeyC+w9ruTPBwYJrJB8nIM2bRvSsuqyghkBEDPfg2yBGAP9b5CVaAAAAAElFTkSuQmCC",
  "temperature": "17",
  "feels_like": "16",
  "temperature_unit": "C",
  "placecode": "CAON0696"
  }
  """
		guard let data = staticData.data(using: .utf8) else {
			throw WeatherAPIError.fileNotFound
		}
		return data
	}
	
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
			throw WeatherAPIError.fileNotFound
		}
		return data
	}
}
