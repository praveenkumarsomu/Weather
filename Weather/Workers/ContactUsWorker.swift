//
//  ContactUsWorker.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import Foundation

/// Contact us store protocol
protocol ContactUsStoreProtocol {
	func submitContactUsDetails(_ request: ContactUsModel.Request) async throws -> Data
}

/// This worker file handles the contact us form submission. As of now we are not interacting with real API, we can do that in future easily by passing different implementation of `ContactUsStoreProtocol` .
class ContactUsWorker {
	let contactUsStore: ContactUsStoreProtocol
	init(store: ContactUsStoreProtocol) {
		self.contactUsStore = store
	}
	func submitContactUsDetails(_ request: ContactUsModel.Request) async throws -> Data {
		return try await contactUsStore.submitContactUsDetails(request)
	}
}
/// Contact us error types, it is very basic now when we integrate API can add new cases into it.
enum ContactUsError: Error {
	case genericError
}
