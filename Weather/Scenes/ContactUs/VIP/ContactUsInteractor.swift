//
//  ContactUsInteractor.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

/// This protocol contains business logic of the contact us page
protocol ContactUsBusinessLogic {
	/// After entering valid data and clicking button submit user details to API SMTP server. As of now no real API call will be implemented.
	/// - Parameter request: User input from contact us page.
	func submitUserDetails(_ request: ContactUsModel.Request) async
	/// Check for submit button state and tell presenter about it.
	func checkForSubmitButtonState(_ interfaceModelList: [ContactUsModel.ViewModel.UserInterfaceModel])
}
extension ContactUsBusinessLogic {
	/// Checks whether the user entered email is valid or not.
	/// - Parameter email: input email that needs to be validated.
	/// - Returns: returns Bool value as result.
	func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}
	/// Checks whether the user entered mobile is valid or not.
	/// Phone number omits the country code for validation as of now text field only allows numbers, it should be more than 6 digits and less or equal to 11 digits. These maximum and minimum number limit is assigned by me can be changed with real values in future.
	/// - Parameter email: input mobile number that needs to be validated.
	/// - Returns: returns Bool value as result.
	func isValidMobileNumber(_ mobile: String) -> Bool {
		let mobileNumberRegex = "[0-9]{7,11}"
		let mobilePredicate = NSPredicate(format:"SELF MATCHES %@", mobileNumberRegex)
		return mobilePredicate.evaluate(with: mobile)
	}
	/// Checks whether the user entered name is valid or not.
	/// Name should contain only alphabets and it should be atleast 4 chnaracters
	/// - Parameter email: input user name that needs to be validated.
	/// - Returns: returns Bool value as result.
	func isValidName(_ name: String) -> Bool {
		let nameRegex = "[a-zA-Z_ ]{4,}"
		let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameRegex)
		return namePredicate.evaluate(with: name)
	}
}
class ContactUsInteractor: ContactUsBusinessLogic {
	/// Presenter protocol, this value is assigned inside `ContactUsTableViewController` `configure` function.
	var presenter: ContactUsPresentationLogic!
	/// Worker class to call submit user details through API, As of now no real API call is implemented.
	var worker: ContactUsWorker
	init(_ worker: ContactUsWorker) {
		self.worker = worker
	}
	func submitUserDetails(_ request: ContactUsModel.Request) async {
		// TODO: In future we can implement actual API call here for now just return mock result.
		guard let data = try? await worker.submitContactUsDetails(request), let message = String(data: data, encoding: .utf8) else {
			return 	presenter.presentContactUsResult(.failure(ContactUsError.genericError))
		}
		let response = ContactUsModel.Response(message: message)
		presenter.presentContactUsResult(.success(response))
	}
	func checkForSubmitButtonState(_ interfaceModelList: [ContactUsModel.ViewModel.UserInterfaceModel]) {
		var emailVerificationResult = false
		var nameVerificationResult = false
		var mobileVerificationResult = false
		interfaceModelList.forEach { model in
			let keyboardInput = model.input ?? ""
			switch model.contentType {
			case .email:
				emailVerificationResult = isValidEmail(keyboardInput)
			case .mobile:
				mobileVerificationResult = isValidMobileNumber(keyboardInput)
			case .name:
				nameVerificationResult = isValidName(keyboardInput)
			}
		}
		let isValidData = emailVerificationResult && nameVerificationResult && mobileVerificationResult
		presenter.updateSubmitButton(isValidInput: isValidData)
	}
}
