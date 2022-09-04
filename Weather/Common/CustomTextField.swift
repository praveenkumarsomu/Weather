//
//  CustomTextField.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

/// This text filed is used to retail keyboard on table view reload
/// - Usage example
/// `cell.offerInputTextField.canResign = false`
/// `tableView.reloadData()`
/// `cell.offerInputTextField.canResign = true`
class CustomTextField: UITextField {
	/// variable to decide key board dismissal, if its false key board will not be dismissed.
	var canResign:Bool = true
	override var canResignFirstResponder: Bool{
		return canResign
	}
}

