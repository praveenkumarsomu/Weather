//
//  ContactUsModel.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

enum ContactUsModel {
	/// This is request model, `ContactUsViewController` construct it and passes to interctor 
	struct Request {
		let name: String
		let email: String
		let mobileNumber: String
	}
	/// Response object from the API as of now no real API is implemented.
	struct Response {
		let message: String
	}
	struct ViewModel {
		/// This viewmodel is used to populate UI on ContactUsTableViewController's table view data
		struct UserInterfaceModel: Equatable {
			/// In case of Text field hint is displayed as place holder and for Button it is displayed as title
			let hint: String
			/// Error message is optional in case if user enter's invalid input we show this message to user to correct input.
			var errorMessage: String?
			/// Type of table view cell to displayon controller.
			let cellType: CellType
			/// User content type
			let contentType: ContentType
			/// `Bool` to determine error state.
			var displayError: Bool = false
			/// User entered string
			var input: String?
		}
		enum CellType {
			case textField
		}
		enum ContentType {
			case email
			case mobile
			case name
		}
		/// This viewmodel is used to display alert message on `ContactUsTableViewController` after API call completion
		struct DataModel: Equatable {
			let message: String
		}
	}
	/// Contact us user interface error cases.
	enum ContactUsError: Error {
		case invalidEmail
		case invalidMobileNumber
		case invalidName
	}
}
