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
		let model = ContactUsModel.ViewModel.DataModel(message: "Success")
		// Act
		presenter.view.displaySuccessMessage(model)
		// Assert
		XCTAssertTrue(mockDisplayLogic.successMethodCalled, "Presenter should call controller on submit form success")
		XCTAssertEqual(mockDisplayLogic.model, model, "Presenter must pass view model to view controller after finishing API")
	}
	func testPresenterShouldPostSubmitFormFailureToVC() {
		// Assign
		let mockDisplayLogic = ContactUsMockController()
		presenter.view = mockDisplayLogic
		let model = ContactUsModel.ViewModel.DataModel(message: "failure")
		// Act
		presenter.view.displayErrorOnAPIFailure(model)
		// Assert
		XCTAssertTrue(mockDisplayLogic.failureMethodCalled, "Presenter should call controller on submit form failure")
		XCTAssertEqual(mockDisplayLogic.model, model, "Presenter must pass view model to view controller after finishing API")
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
	func displaySuccessMessage(_ viewModel: ContactUsModel.ViewModel.DataModel) {
		successMethodCalled = true
		model = viewModel
	}
	
	func displayErrorOnAPIFailure(_ viewModel: ContactUsModel.ViewModel.DataModel) {
		failureMethodCalled = true
		model = viewModel
	}
	
	func updateSubmitButton(_ isValidInput: Bool) {
		submitButtonStateUpdateCalled = true
		submitButtonState = isValidInput
	}
	
}
