//
//  ContactUsInputTableViewCell.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

class ContactUsInputTableViewCell: UITableViewCell {
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var errorLabel: UILabel!
	var inputChanged: ((String) -> Void)?
	override func awakeFromNib() {
		super.awakeFromNib()
		textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
	}
	/// Configure text field and error message labels
	/// - Parameters:
	///   - model: user interface model
	///   - delegate: text field delegate. Normally it is assigned to view controller.
	func configureUI(model: ContactUsModel.ViewModel.UserInterfaceModel, delegate: UITextFieldDelegate) {
		textField.delegate = delegate
		textField.placeholder = model.hint
		textField.text = model.input
		errorLabel.text = model.errorMessage
		errorLabel.isHidden = !model.displayError
		switch model.contentType {
		case .email:
			textField.keyboardType = .emailAddress
		case .mobile:
			textField.keyboardType = .numberPad
		default: break
		}
	}
	@objc func textFieldDidChange() {
		inputChanged?(textField.text ?? "")
	}
}
