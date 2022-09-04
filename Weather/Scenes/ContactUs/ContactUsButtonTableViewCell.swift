//
//  ContactUsButtonTableViewCell.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

class ContactUsButtonTableViewCell: UITableViewCell {
	@IBOutlet weak var submitButton: UIButton!
	var submitButtonAction: (() -> Void)?
	func configureUI(title: String) {
		submitButton.setTitle(title, for: .normal)
	}

	@IBAction func submitButtonAction(_ sender: UIButton) {
		submitButtonAction?()
	}
}
