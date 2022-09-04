//
//  UIViewController+Extension.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

extension UIViewController {
	/// Displays alert with single action
	/// - Parameters:
	///   - title: alert controller title
	///   - message: alert controller message
	///   - actionTitle: alert action title
	///   - action: action call back
	func showAlertWithSingleButtonAction(title: String, message: String, actionTitle: String, action: (() -> Void)?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: actionTitle, style: .default) { _ in
			action?()
		}
		alert.addAction(action)
		present(alert, animated: true)
	}
}
