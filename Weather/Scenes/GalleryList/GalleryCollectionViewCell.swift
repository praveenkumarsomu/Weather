//
//  GalleryCollectionViewCell.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import UIKit

/// Collection view cell to display gallery images on `GalleryViewController`.
class GalleryCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	/// Configure collection view cell
	/// - Parameter name: UIimage object that need to be displayed.
	func configureUI(_ name: UIImage?) {
		imageView.contentMode = .scaleAspectFill
		imageView.image = name
	}
	override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
		let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
		let availableWidth = (UIScreen.main.bounds.width - 48) / 3
		let size = CGSize(width: availableWidth, height: availableWidth)
		attributes.size = size
		return attributes
	}
}
