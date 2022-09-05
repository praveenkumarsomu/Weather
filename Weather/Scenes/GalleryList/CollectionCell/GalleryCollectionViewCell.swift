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
	/// Calculate collection view cell size dynamically
	override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
		let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
		/// Here value `48` include trailing, leading spaces and column spacing, as of now we show 3 columns so diving available space with `3`.
		let availableWidth = (UIScreen.main.bounds.width - 48) / 3
		/// Image view aspect ratio on list screen is 1:1
		let size = CGSize(width: availableWidth, height: availableWidth)
		attributes.size = size
		return attributes
	}
}
