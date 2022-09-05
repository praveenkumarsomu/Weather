//
//  ContactUsTableViewController.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

/// Display result to user after API call completion.
protocol ContactUsDisplayLogic {
	/// Display success alert and pop back to city list screen
	/// - Parameter viewModel: alert message
	func displaySuccessMessage(_ viewModel: ContactUsModel.ViewModel.DataModel)
	/// Displays error in case of any
	/// - Parameter viewModel: alert message
	func displayErrorOnAPIFailure(_ viewModel: ContactUsModel.ViewModel.DataModel)
	/// Enable or disable Submit button based on user input data
	/// - Parameter isValidInput: `Bool` value that determines the submit button state.
	func updateSubmitButton(_ isValidInput: Bool)
}

class ContactUsViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var submitButton: UIButton!
	@IBOutlet weak var tableFooterView: UIView!
	
	var interactor: ContactUsBusinessLogic!
	var displayedCells: [ContactUsModel.ViewModel.UserInterfaceModel] = []
	let constants: Constants = Constants()
	var userEnteredValidData: Bool = false
	override func awakeFromNib() {
		super.awakeFromNib()
		configure()
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
    }
	/// This function initialises and resolves the mapping between View controller -> Interactor -> Presenter
	private func configure() {
		let contactUsStore = ContactUsLocalAPI()
		let worker = ContactUsWorker(store: contactUsStore)
		let interactor = ContactUsInteractor(worker)
		let presenter = ContactUsPresenter()
		self.interactor = interactor
		interactor.presenter = presenter
		presenter.view = self
	}
	/// Perform basic UI tasks on view load like setting screen titles, etc.
	private func configureUI() {
		self.title = constants.contactUs
		self.navigationController?.navigationBar.prefersLargeTitles = true
		submitButton.setTitle(constants.submit, for: .normal)
		submitButton.isEnabled = false
		getUserInterfaceModel()
		tableView.tableFooterView = tableFooterView
		tableView.reloadData()
	}
	/// Configure table view cell model
	private func getUserInterfaceModel() {
		let constants = Constants()
		let nameModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.name, errorMessage: constants.invalidName, cellType: .textField, contentType: .name)
		let mobileNumberModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.mobileNumber, errorMessage: constants.invalidMobileNumber, cellType: .textField, contentType: .mobile)
		let emailModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.email, errorMessage: constants.invalidEmail, cellType: .textField, contentType: .email)
		let displayedUserInterfaceModel = [nameModel, emailModel, mobileNumberModel]
		displayedCells = displayedUserInterfaceModel
	}
	/// Validate user entered input
	/// - Parameters:
	///   - contentType: data type to validate
	///   - input: User entered input 
	private func validateInput(contentType: ContactUsModel.ViewModel.ContentType, _ input: String) {
		var isValidInput = false
		switch contentType {
		case .email:
			isValidInput = interactor.isValidEmail(input)
		case .mobile:
			isValidInput = interactor.isValidMobileNumber(input)
		case .name:
			isValidInput = interactor.isValidName(input)
		}
		updateViewModelErrorMessage(contentType, !isValidInput, input)
		interactor.checkForSubmitButtonState(displayedCells)
	}
	/// Update displayedCells after validating data to show or hide error
	/// - Parameters:
	///   - contentType: row needs to be reloaded
	///   - displayError: `Bool` value to display error or not.
	private func updateViewModelErrorMessage(_ contentType: ContactUsModel.ViewModel.ContentType, _ displayError: Bool, _ input: String) {
		guard let index = displayedCells.firstIndex(where: { $0.contentType == contentType}) else {
			return
		}
		var updatedModel: ContactUsModel.ViewModel.UserInterfaceModel?
		switch contentType {
		case .email:
			updatedModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.email, errorMessage: constants.invalidEmail, cellType: .textField, contentType: .email, displayError: displayError, input: input)
		case .name:
			updatedModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.name, errorMessage: constants.invalidName, cellType: .textField, contentType: .name, displayError: displayError, input: input)
		case .mobile:
			updatedModel = ContactUsModel.ViewModel.UserInterfaceModel(hint: constants.mobileNumber, errorMessage: constants.invalidMobileNumber, cellType: .textField, contentType: .mobile, displayError: displayError, input: input)
		}
		guard let updatedModel = updatedModel else {
			return
		}
		displayedCells[index] = updatedModel
		/// Currently we are not reloading table view to retain keyboard, we can improve this implementing any one of below
		/// 1. implementing custom textfield by overriding variable `canResignFirstResponder`.
		/// 2. Display error message out side table view instead below text field
		/// 3. Store current editing index and make textfield` firstResponder` again.
		/// As of now for simplicity just accessing the cell and reloading the content.
		let indexPath = IndexPath(row: index, section: .zero)
		let cell = tableView.cellForRow(at: indexPath) as? ContactUsInputTableViewCell
		cell?.configureUI(model: updatedModel, delegate: self)
	}
	
	@IBAction func submitButtonTapped(_ sender: UIButton) {
		/// We can eliminate this filter logic by assigning user input to local variable I prefer to do this way because there is single point of truth. As of now we have only 3 cells it wouldn't be a issue but if the input cells count is large number we can refractor this using above said method.
		guard let name = displayedCells.first(where: {$0.contentType == .name})?.input,
		let mobile = displayedCells.first(where: {$0.contentType == .mobile})?.input,
			  let email = displayedCells.first(where: {$0.contentType == .email})?.input else {
			return
		}
		let request = ContactUsModel.Request(name: name, email: email, mobileNumber: mobile)
		Task.detached { [weak self] in
			await self?.interactor.submitUserDetails(request)
		}
	}
}
//MARK: Table view data source
extension ContactUsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		displayedCells.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let model = displayedCells[safe: indexPath.row] else { return UITableViewCell() }
		switch model.cellType {
		case .textField:
			guard let textFieldCell = tableView.dequeueReusableCell(withIdentifier: constants.contactUsTextFieldCell) as? ContactUsInputTableViewCell else {
				return UITableViewCell()
			}
			textFieldCell.configureUI(model: model, delegate: self)
			textFieldCell.inputChanged = { [weak self] input in
				self?.validateInput(contentType: model.contentType, input)
			}
			textFieldCell.selectionStyle = .none
			return textFieldCell
		}
	}
}

//MARK: Presenter output
extension ContactUsViewController: ContactUsDisplayLogic {
	func displaySuccessMessage(_ viewModel: ContactUsModel.ViewModel.DataModel) {
		showAlertWithSingleButtonAction(title: constants.success, message: viewModel.message, actionTitle: constants.okayButtonTitle) { [weak self] in
			self?.navigationController?.popViewController(animated: true)
		}
	}
	func displayErrorOnAPIFailure(_ viewModel: ContactUsModel.ViewModel.DataModel) {
		showAlertWithSingleButtonAction(title: constants.error, message: viewModel.message, actionTitle: constants.okayButtonTitle) { }
	}
	func updateSubmitButton(_ isValidInput: Bool) {
		submitButton.isEnabled = isValidInput
	}
}

//MARK: UITextField delegate
extension ContactUsViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
