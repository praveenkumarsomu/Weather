//
//  ContactUsPresenter.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

/// Presenter logic for Contact us
protocol ContactUsPresentationLogic {
	/// After completing API call receive call from interactor `ContactUsInteractor` to display result in `ContactUsViewController`.
	/// - Parameter result: This message is alert message title that will be shown on `ContactUsViewController`.
	func presentContactUsResult(_ result: Result<ContactUsModel.Response, ContactUsError>)
	/// Update the state of the submit button
	/// - Parameter isValidInput: Bool value if it is `true` submit button is toggled to enabled state.
	func updateSubmitButton(isValidInput: Bool)
}

/// Presenter implementation of Contact us feature.
class ContactUsPresenter: ContactUsPresentationLogic {
	var view: ContactUsDisplayLogic!
	let constants: Constants = Constants()
	func presentContactUsResult(_ result: Result<ContactUsModel.Response, ContactUsError>) {
		DispatchQueue.main.async { [weak self] in
			guard let self =  self else { return }
			switch result {
			case .success(let response):
				let viewModel = ContactUsModel.ViewModel.DataModel(message: response.message)
				self.view.displaySuccessMessage(viewModel)
			case .failure:
				// TODO: When actual API is implemented try to consume error message posted by API call.
				let viewModel = ContactUsModel.ViewModel.DataModel(message: self.constants.contactUsErrorMessage)
				self.view.displayErrorOnAPIFailure(viewModel)
			}
		}
	}
	func updateSubmitButton(isValidInput: Bool) {
		view.updateSubmitButton(isValidInput)
	}
}
