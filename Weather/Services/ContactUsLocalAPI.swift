//
//  ContactUsMockAPI.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation


class ContactUsLocalAPI: ContactUsStoreProtocol {
	func submitContactUsDetails(_ request: ContactUsModel.Request) async throws -> Data {
		let userRequestId = arc4random_uniform(1000000)
		guard let data = "Details submitted successfully, we will contact you soon. Save your request Id for further communication \(userRequestId).".data(using: .utf8) else {
			throw ContactUsError.genericError
		}
		return data
	}
}
