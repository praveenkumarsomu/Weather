//
//  ContactUsLocalAPITests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import XCTest
@testable import Weather

class ContactUsLocalAPITests: XCTestCase {
	var contactUsLocalAPI: ContactUsLocalAPI!
    override func setUpWithError() throws {
		contactUsLocalAPI = ContactUsLocalAPI()
    }

    override func tearDownWithError() throws {
		contactUsLocalAPI = nil
    }
	
	func testSubmittingForm() async throws {
		// Assign
		let request = ContactUsModel.Request(name: "Praveen", email: "praveen@gmail.com", mobileNumber: "12345678")
		let resultString = "Details submitted successfully, we will contact you soon. Save your request Id for further communication"
		// Act
		let data = try await contactUsLocalAPI.submitContactUsDetails(request)
		// Assert
		XCTAssertNotNil(data, "contact us local API should return valid data")
		guard let stringFromAPI = String(data: data, encoding: .utf8) else {
			XCTFail("unable to construct string from data")
			return
		}
		XCTAssertTrue(stringFromAPI.contains(resultString), "Format of the result string is wrong")
	}

}
