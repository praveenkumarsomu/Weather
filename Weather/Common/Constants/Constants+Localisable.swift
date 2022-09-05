//
//  Constants+Localisable.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

/// Declare all the localisable strings in one file it will be easy to implement localisation in future.
extension Constants {
	//MARK: Button, Label,text field and alert content
	var weather: String { "Weather" } 
	var contactUs: String { "Contact Us" }
	var gallery: String { "Gallery" }
	var submit: String { "Submit" }
	var mobileNumber: String { "Mobile Number" }
	var email: String { "Email" }
	var name: String { "Enter your name" }
	var degree: String { "Degree" }
	var chooseDegree: String { "Choose Degree" }
	var celsius: String { "Celsius" }
	var fahrenheit: String { "Fahrenheit" }
	var cancel: String { "Cancel" }
	var itFeelsLike: String { "It feels like" }
	var currentTemparatureIs: String { "Current temparature is" }
	var weatherCondition: String { "Weather Condition is" }
	//MARK: Error Messages
	var error: String { "Error" }
	var okayButtonTitle: String { "OK" }
	var cancelButtonTitle: String { "Cancel" }
	var cityListAPIFailureMessage: String { "Failed to load cities list, please try again later." }
	var contactUsErrorMessage: String { "Some thing went wrong, try again later." }
	var invalidEmail: String { "Invalid email address." }
	var invalidName: String  {"Invalid name." }
	var invalidMobileNumber: String { "Invalid mobile number." }
	var selectedCityIsNotFound: String { "Selected city not found." }
	var weatherDetailsNotFound: String { "Weather details for selected city not found, please try after some time." }
	var unableToFetchImages: String { "Unable to fetch images, please try again later." }
	var unableToDisplayFullImage: String { "Unable to load full size image." }
	var success: String { "Success" }
}
