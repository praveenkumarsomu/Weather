//
//  ContactUsInteractorTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import XCTest
@testable import Weather

class ContactUsInteractorTests: XCTestCase {
	var interactor: ContactUsInteractor!
	var mockStore: ContactUsMockAPI!
	var worker: ContactUsWorker!
	override func setUpWithError() throws {
		mockStore = ContactUsMockAPI()
		worker = ContactUsWorker(store: mockStore)
		interactor = ContactUsInteractor(worker)
	}
	
    override func tearDownWithError() throws {
		mockStore = nil
		worker = nil
		interactor = nil
    }
	func testInteractorShouldCallSubmitFormWorkerAndUpdatePresenter() async throws {
		// Assign
		let presenter = ContactUsMockPresenter()
		interactor.presenter = presenter
		let request = ContactUsModel.Request(name: "Praveen", email: "praveen@gmail.com", mobileNumber: "1234567")
		// Act
		let expectation = expectation(description: "Interactor submission call")
		presenter.presentationCallback = {
			// Assert
			XCTAssertTrue(presenter.interactorCalledPresenter, "Interactor should update result to presenter")
			XCTAssertTrue(self.mockStore.storeAPICalled, "Interactor should call worker to submit form")
			expectation.fulfill()
		}
		try await interactor.submitUserDetails(request)
		await waitForExpectations(timeout: 3.0)
	}
	func testInteractorShouldUpdateSubmitButtonStateToPresenter() {
		// Assign
		let mockStore = ContactUsMockAPI()
		let worker = ContactUsWorker(store: mockStore)
		interactor = ContactUsInteractor(worker)
		let presenter = ContactUsMockPresenter()
		interactor.presenter = presenter
		// Act
		interactor.checkForSubmitButtonState([])
		// Assert
		XCTAssertTrue(presenter.submitButtonStateCalled, "Interactor should update submit button state to presenter")
	}
	func testInvalidEmailValidation() {
		let invalidEmails = ["Praveen", "Praveen.@", "", "@@#$", "Praveeb.com"]
		invalidEmails.forEach { invalidEmail in
			let result = self.interactor.isValidEmail(invalidEmail)
			XCTAssertFalse(result, "Email validator should trigger invalid email formats")
		}
	}
	func testValidEmailValidation() {
		// Assign
		let validEmails = ["Praveen@gmail.com", "Praveen@gmil.co", "p@abc.net"]
		// Assert
		validEmails.forEach { email in
			let result = self.interactor.isValidEmail(email)
			XCTAssertTrue(result, "Email validator should not identify valid emails as invalid")
		}
	}
	func testInValidUserName() {
		// Assign
		let names = ["Praveen123", "praveen#", "a", "1234"]
		// Assert
		names.forEach { name in
			let result = interactor.isValidName(name)
			XCTAssertFalse(result, "User name validator should not trigger invalid name as valid")
		}
	}
	func testValidUserName() {
		// Assign
		let names = ["Praveen", "praveen kumar", "abcd"]
		// Assert
		names.forEach { name in
			let result = interactor.isValidName(name)
			XCTAssertTrue(result, "User name validator should not trigger valid name as invalid")
		}
	}
	func testInValidMobilenumbers() {
		// Assign
		let mobileNumbers = ["Praveen", "1234", "123456",  "1234567@", "0122345678902392"]
		// Assert
		mobileNumbers.forEach { mobile in
			let result = interactor.isValidMobileNumber(mobile)
			XCTAssertFalse(result, "Mobile number validator should not trigger invalid mobile as valid")
		}
	}
	func testValidMobileNumbers() {
		// Assign
		let mobileNumbers = ["1234567", "08112369622", "123456789"]
		// Assert
		mobileNumbers.forEach { mobile in
			let result = interactor.isValidMobileNumber(mobile)
			XCTAssertTrue(result, "Mobile number validator should not trigger valid mobile as invalid")
		}
	}
}

class ContactUsMockPresenter: ContactUsPresentationLogic {
	var interactorCalledPresenter = false
	var submitButtonStateCalled = false
	var presentationCallback: (() -> Void)?
	func presentContactUsResult(_ result: Result<ContactUsModel.Response, ContactUsError>) {
		interactorCalledPresenter = true
		presentationCallback?()
	}
	
	func updateSubmitButton(isValidInput: Bool) {
		submitButtonStateCalled = true
	}
	
}

class ContactUsMockAPI: ContactUsStoreProtocol {
	var storeAPICalled: Bool = false
	func submitContactUsDetails(_ request: ContactUsModel.Request) async throws -> Data {
		storeAPICalled = true
		return Data()
	}
}
