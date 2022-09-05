//
//  WeatherLocalAPITests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class WeatherLocalAPITests: XCTestCase {
	var weatherLocalAPI: WeatherLocalAPI!
    override func setUpWithError() throws {
		weatherLocalAPI = WeatherLocalAPI()
    }

    override func tearDownWithError() throws {
		weatherLocalAPI = nil
	}

	func testLocalCityList() async throws {
		// Assign
		let cities = ["Toronto": "CAON0696", "Montreal": "CAON0423", "Ottawa": "CAON0512", "Vancouver": "CABC0308", "Calgary": "CAAB0049"]
		// Act
		let data = try await weatherLocalAPI.fetchCityList()
		XCTAssertNotNil(data, "Data from the local city list file should not be nil")
		let cityListObject = try JSONDecoder().decode(CityListModel.Response.self, from: data)
		// Assert
		XCTAssertNotNil(data, "data from cities.json file should not be nil")
		cities.forEach { localCity in
			let city = cityListObject.cities.first(where: {$0.name == localCity.key})
			XCTAssertNotNil(city, "Cities list does not contal all the required values")
			XCTAssertEqual(city?.code, localCity.value, "Cities list does not contal all the required values")
		}
		
	}
}
