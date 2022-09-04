//
//  ContactUsWorker.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

protocol ContactUsStoreProtocol {
	func submitContactUsDetails(_ request: ContactUsModel.Request) async throws -> Data
}

class ContactUsWorker {
	let contactUsStore: ContactUsStoreProtocol
	init(store: ContactUsStoreProtocol) {
		self.contactUsStore = store
	}
	func submitContactUsDetails(_ request: ContactUsModel.Request) async throws -> Data {
		return try await contactUsStore.submitContactUsDetails(request)
	}
}

enum ContactUsError: Error {
	case genericError
}
