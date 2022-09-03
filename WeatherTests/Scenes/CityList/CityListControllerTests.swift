//
//  CityListControllerTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import XCTest
@testable import Weather

class CityListControllerTests: XCTestCase {
	var cityListViewController: CityListViewController!
    override func setUpWithError() throws {
		setupListCitiesViewController()
    }

    override func tearDownWithError() throws {
    }
	func setupListCitiesViewController() {
	  let bundle = Bundle.main
	  let storyboard = UIStoryboard(name: "Main", bundle: bundle)
	  cityListViewController = storyboard.instantiateViewController(withIdentifier: String(describing: CityListViewController.self)) as? CityListViewController
	}
	func loadView() {
		cityListViewController.beginAppearanceTransition(true, animated: true)
	}
    func testNumberOfSectionsInTableView() throws {
        loadView()
		let tableView = cityListViewController.tableView
		XCTAssertEqual(tableView?.numberOfSections, 1, "Number of sections in table view should be always one")
    }
	func testNumberOfRowsInTableView() {
		loadView()
		let mockResponse = CityListModel.ViewModel(cities: [CityListModel.ViewModel.City(name: "Toronto", code: "CAON0696")])
		cityListViewController.displayedCities = mockResponse
		let tableView = cityListViewController.tableView
		XCTAssertEqual(tableView?.numberOfRows(inSection: .zero), 1, "Number of rows in table view should be always equal to diaplayedCities")
	}
	func testTableViewCellConfiguration() {
		loadView()
		let mockResponse = CityListModel.ViewModel(cities: [CityListModel.ViewModel.City(name: "Toronto", code: "CAON0696")])
		cityListViewController.displayedCities = mockResponse
		let tableView = cityListViewController.tableView
		let indexPath = IndexPath(row: .zero, section: .zero)
		let cell = cityListViewController.tableView(tableView!, cellForRowAt: indexPath)
		XCTAssertEqual(cell.textLabel?.text, "Toronto", "Cell text should always be city name")
		XCTAssertEqual(cell.accessoryType, .disclosureIndicator, "Cell text should always display disclosure indicator")
	}
	func testFetchingCityListOnViewDidLoad() {
		let mockInteractor = CityListMockInterctor()
		cityListViewController.interactor = mockInteractor
		let expectation = expectation(description: "Wait for city list API")
		loadView()
		mockInteractor.asyncCallTriggeredCallback = {
			XCTAssertTrue(mockInteractor.fetchCitiesCalled, "Should fetch cities right after view loads")
			expectation.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
}
//MARK: Mock interactor
class CityListMockInterctor: CityListViewBusinessLogic {
	var cities: CityListModel.Response!
	var asyncCallTriggeredCallback: (() -> Void)?
  // MARK: Method call expectations
  
  var fetchCitiesCalled = false
  
  // MARK: Spied methods
	func getCityList(_ request: CityListModel.Request) async {
		fetchCitiesCalled = true
		asyncCallTriggeredCallback?()
	}
}
