//
//  Constants+Localisable.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

/// Declare all the localisable strings in one file it will be easy to implement localisation in future.
extension Constants {
	//MARK: Button and text field titles and placeholders
	var contactUs: String { "Contact Us" }
	var gallery: String { "Gallery" }
	var submit: String { "Submit" }
	var mobileNumber: String { "Mobile Number" }
	var email: String { "Email" }
	var name: String { "Enter your name" }
	//MARK: Error Messages
	var error: String { "Error" }
	var okayButtonTitle: String { "OK" }
	var cancelButtonTitle: String { "Cancel" }
	var cityListAPIFailureMessage: String { "Failed to load cities list, please try again later." }
	var contactUsErrorMessage: String { "Some thing went wrong, try again later." }
	var invalidEmail: String { "Invalid email address." }
	var invalidName: String  {"Invalid name." }
	var invalidMobileNumber: String { "Invalid mobile number." }
	var success: String { "Success" }
}
