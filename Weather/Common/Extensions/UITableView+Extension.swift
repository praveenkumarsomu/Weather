//
//  UITableView+Extension.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

extension UITableView {
	func registerNib(cell: String) {
		register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
	}
}
