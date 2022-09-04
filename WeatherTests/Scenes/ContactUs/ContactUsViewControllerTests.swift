//
//  ContactUsViewControllerTests.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import XCTest
@testable import Weather

class ContactUsViewControllerTests: XCTestCase {
	var controller: ContactUsViewController!
	let constants = Constants()
    override func setUpWithError() throws {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		guard let controller = storyBoard.instantiateViewController(withIdentifier: String(describing: ContactUsViewController.self)) as? ContactUsViewController else {
			XCTFail("Failed to initialise ContactUsViewController from storyboard")
			return
		}
		self.controller = controller
		loadView()
    }
	override func tearDownWithError() throws {
		controller = nil
	}
	func loadView() {
		controller.beginAppearanceTransition(true, animated: true)
	}
	func testConstructingViewModelOnViewDidLoad() {
		// Assign
		let nameModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.name, errorMessage: constants.invalidName, cellType: .textField, contentType: .name)
		let mobileNumberModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.mobileNumber, errorMessage: constants.invalidMobileNumber, cellType: .textField, contentType: .mobile)
		let emailModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.email, errorMessage: constants.invalidEmail, cellType: .textField, contentType: .email)
		let displayedUserInterfaceModel = [nameModel, emailModel, mobileNumberModel]
		// Assert
		XCTAssertEqual(controller.displayedCells, displayedUserInterfaceModel, "On view load of the contact us screen controller should construct user interface model to display cells")
	}
	func testNumberOfSections() {
		// Assert
		XCTAssertEqual(controller.tableView.numberOfSections, 1, "Contact us section should have only one section")
	}
	func testNumberOfRowsInSection() {
		// Assert
		XCTAssertEqual(controller.tableView.numberOfRows(inSection: .zero), 3, "Contact us section zero should have 3 rows")
	}
	func testConfiguringNameTableViewCell() {
		/// Name cell
		// Assign
		let indexPath = IndexPath(row: 0, section: 0)
		guard let cell = controller.tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index zero")
			return
		}
		// Assert
		XCTAssertNotNil(cell.inputChanged, "ContactUsViewController must assign text change call back")
		XCTAssertEqual(cell.textField.placeholder, constants.name, "Name field should be displayed at row zero with Enter your name as text field place holder")
		XCTAssertTrue(cell.errorLabel.isHidden, "On view load no eror state is displayed on name field")
		XCTAssertEqual(cell.errorLabel.text, constants.invalidName, "Error text is wrong on name cell")
	}
	func testConfiguringEmailTableViewCell() {
		/// Email cell
		// Assign
		let indexPath = IndexPath(row: 1, section: 0)
		guard let cell = controller.tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index one")
			return
		}
		// Assert
		XCTAssertNotNil(cell.inputChanged, "ContactUsViewController must assign text change call back")
		XCTAssertEqual(cell.textField.placeholder, constants.email, "Email field should be displayed at row one with Email as text field place holder")
		XCTAssertTrue(cell.errorLabel.isHidden, "On view load no eror state is displayed on name field")
		XCTAssertEqual(cell.errorLabel.text, constants.invalidEmail, "Error text is wrong on Email cell")
	}
	func testConfiguringMobileTableViewCell() {
		/// Email cell
		// Assign
		let indexPath = IndexPath(row: 2, section: 0)
		guard let cell = controller.tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index one")
			return
		}
		// Assert
		XCTAssertNotNil(cell.inputChanged, "ContactUsViewController must assign text change call back")
		XCTAssertEqual(cell.textField.placeholder, constants.mobileNumber, "Mobile field should be displayed at row two with Mobile Number as text field place holder")
		XCTAssertTrue(cell.errorLabel.isHidden, "On view load no eror state is displayed on name field")
		XCTAssertEqual(cell.errorLabel.text, constants.invalidMobileNumber, "Error text is wrong on Email cell")
	}
	func testTextFieldDelegateMethodsTrigger() {
		// Assign
		let indexPath = IndexPath(row: 1, section: 0)
		guard let cell = controller.tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index one")
			return
		}
		var inputString: String!
		cell.inputChanged = { input in
			inputString = input
		}
		cell.textField.text = "Mock"
		// Act
		cell.textFieldDidChange()
		// Assert
		XCTAssertEqual(inputString, "Mock", "Text field change should be communicated back to controller")
	}
	func testNameCellErrorDisplayTrigger() {
		// Assign
		let indexPath = IndexPath(row: 0, section: 0)
		guard let cell = controller.tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index zero")
			return
		}
		cell.textField.text = "p"
		// Act
		cell.inputChanged?(cell.textField.text ?? "")
		// Assert
		guard let emailInterfaceModel = controller.displayedCells.first(where: {$0.contentType == .name}) else {
			XCTFail("Unable to find name user interface model in displayedCells")
			return
		}
		XCTAssertTrue(emailInterfaceModel.displayError, "Error should be displayed on invalid name input")
	}
	func testEmailCellErrorDisplayTrigger() {
		// Assign
		let indexPath = IndexPath(row: 1, section: 0)
		guard let cell = controller.tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index one")
			return
		}
		cell.textField.text = "invalid email"
		// Act
		cell.inputChanged?(cell.textField.text ?? "")
		// Assert
		guard let emailInterfaceModel = controller.displayedCells.first(where: {$0.contentType == .email}) else {
			XCTFail("Unable to find email user interface model in displayedCells")
			return
		}
		XCTAssertTrue(emailInterfaceModel.displayError, "Error should be displayed on invalid email input")
	}
	func testMobileCellErrorDisplayTrigger() {
		// Assign
		let indexPath = IndexPath(row: 2, section: 0)
		guard let cell = controller.tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index two")
			return
		}
		cell.textField.text = "123" // Enter invalid mobile number
		// Act
		cell.inputChanged?(cell.textField.text ?? "")
		// Assert
		guard let emailInterfaceModel = controller.displayedCells.first(where: {$0.contentType == .mobile}) else {
			XCTFail("Unable to find mobile user interface model in displayedCells")
			return
		}
		XCTAssertTrue(emailInterfaceModel.displayError, "Error should be displayed on invalid mobile number input")
	}
	func testFormSubmissionCalled() {
		// Assign
		let interactor = ContactUsMockInteractor()
		controller.interactor = interactor
		let nameModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.name, errorMessage: constants.invalidName, cellType: .textField, contentType: .name, input: "Praveen")
		let mobileNumberModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.mobileNumber, errorMessage: constants.invalidMobileNumber, cellType: .textField, contentType: .mobile, input: "81123695")
		let emailModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.email, errorMessage: constants.invalidEmail, cellType: .textField, contentType: .email, input: "Praveen@gmail.com")
		let displayedUserInterfaceModel = [nameModel, emailModel, mobileNumberModel]
		controller.displayedCells = displayedUserInterfaceModel
		let expectation = expectation(description: "Submit button action")
		// Act
		controller.submitButton.sendActions(for: .touchUpInside)
		// Assert
		interactor.submissionCallBack = {
			XCTAssertTrue(interactor.formSubmmissioncalled, "Submit button action should call interactor to trigger API")
			expectation.fulfill()
		}
		waitForExpectations(timeout: 3.0)
	}
	func testButtonStateValidationTrigger() {
		// Assign
		let interactor = ContactUsMockInteractor()
		controller.interactor = interactor
		let indexPath = IndexPath(row: 2, section: 0)
		guard let cell = controller.tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index two")
			return
		}
		cell.textField.text = "123" // Enter invalid mobile number
		// Act
		cell.inputChanged?(cell.textField.text ?? "")
		// Assert
		XCTAssertTrue(interactor.checkForSubmitButtonStateCalled, "Each Input change should trigger submit button state update request")
		XCTAssertFalse(controller.submitButton.isEnabled, "Submit button should be disabled for invalid input")
	}
	func testSubmitButtonEnableStateOnValidInput() {
		// Assign
		/// Name cell
		let indexPath0 = IndexPath(row: 0, section: 0)
		guard let nameCell = controller.tableView.cellForRow(at: indexPath0) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index two")
			return
		}
		nameCell.textField.text = "Praveen" // Valid name

		let indexPath1 = IndexPath(row: 1, section: 0)
		guard let emailCell = controller.tableView.cellForRow(at: indexPath1) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index two")
			return
		}
		emailCell.textField.text = "praveen@gmail.com" // valid email
		/// Mobile number cell
		let indexPath2 = IndexPath(row: 2, section: 0)
		guard let mobileCell = controller.tableView.cellForRow(at: indexPath2) as? ContactUsInputTableViewCell else {
			XCTFail("Unable to get contact us cell at index two")
			return
		}
		mobileCell.textField.text = "1234567" // valid mobile number
		// Act
		mobileCell.inputChanged?(mobileCell.textField.text ?? "")
		nameCell.inputChanged?(nameCell.textField.text ?? "")
		emailCell.inputChanged?(emailCell.textField.text ?? "")
		// Assert
		XCTAssertTrue(controller.submitButton.isEnabled, "Submit button should be disabled for invalid input")
	}
}

class ContactUsMockInteractor: ContactUsBusinessLogic {
	var formSubmmissioncalled = false
	var checkForSubmitButtonStateCalled = false
	var submissionCallBack: (() -> Void)?
	func submitUserDetails(_ request: ContactUsModel.Request) async throws {
		formSubmmissioncalled = true
		submissionCallBack?()
	}
	
	func checkForSubmitButtonState(_ interfaceModelList: [ContactUsModel.ViewModel.UserInterfaceModel]) {
		checkForSubmitButtonStateCalled = true
	}
	
}
