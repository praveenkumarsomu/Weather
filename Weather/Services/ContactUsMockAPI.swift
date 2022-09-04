//
//  ContactUsMockAPI.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation


class ContactUsMockAPI: ContactUsStoreProtocol {
	func submitContactUsDetails(_ request: ContactUsModel.Request) async throws -> Data {
		guard let data = "Details submitted successfully, we will contact you soon.".data(using: .utf8) else {
			throw ContactUsError.genericError
		}
		return data
	}
}
