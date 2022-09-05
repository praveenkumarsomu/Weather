//
//  ContactUsPresenterTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import XCTest
@testable import Weather

class ContactUsPresenterTests: XCTestCase {
	var presenter: ContactUsPresenter!
    override func setUpWithError() throws {
		presenter = ContactUsPresenter()
    }

    override func tearDownWithError() throws {
		presenter = nil
    }
	
	func testPresenterShouldPostSubmitFormSuccessToVC() {
		// Assign
		let mockDisplayLogic = ContactUsMockController()
		presenter.view = mockDisplayLogic
		let response = ContactUsModel.Response(message: "Success")
		let model = ContactUsModel.ViewModel.DataModel(message: response.message)
		// Act
		presenter.presentContactUsResult(.success(response))
		let expectation = expectation(description: "Presenter to view call back")
		mockDisplayLogic.callBack = {
			// Assert
			XCTAssertTrue(mockDisplayLogic.successMethodCalled, "Presenter should call controller on submit form success")
			XCTAssertEqual(mockDisplayLogic.model, model, "Presenter must pass view model to view controller after finishing API")
			expectation.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
	func testPresenterShouldPostSubmitFormFailureToVC() {
		// Assign
		let mockDisplayLogic = ContactUsMockController()
		presenter.view = mockDisplayLogic
		// Act
		let expectation = expectation(description: "Presenter to view call back")
		presenter.presentContactUsResult(.failure(.genericError))
		mockDisplayLogic.callBack = {
			// Assert
			XCTAssertTrue(mockDisplayLogic.failureMethodCalled, "Presenter should call controller on submit form failure")
			expectation.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
	func testPresenterShouldPostSubmitButtonUpdateToVC() {
		// Assign
		let mockDisplayLogic = ContactUsMockController()
		presenter.view = mockDisplayLogic
		// Act
		presenter.view.updateSubmitButton(true)
		// Assert
		XCTAssertTrue(mockDisplayLogic.submitButtonStateUpdateCalled, "Presenter should call controller on submit form failure")
		XCTAssertTrue(mockDisplayLogic.submitButtonState, "Presenter should pass valid button state to view controller")
	}
}

class ContactUsMockController: ContactUsDisplayLogic {
	var successMethodCalled = false
	var failureMethodCalled = false
	var submitButtonStateUpdateCalled = false
	var model: ContactUsModel.ViewModel.DataModel!
	var submitButtonState = false
	var callBack: (() -> Void)?
	func displaySuccessMessage(_ viewModel: ContactUsModel.ViewModel.DataModel) {
		successMethodCalled = true
		model = viewModel
		callBack?()
	}
	
	func displayErrorOnAPIFailure(_ viewModel: ContactUsModel.ViewModel.DataModel) {
		failureMethodCalled = true
		model = viewModel
		callBack?()
	}
	
	func updateSubmitButton(_ isValidInput: Bool) {
		submitButtonStateUpdateCalled = true
		submitButtonState = isValidInput
	}
	
}
