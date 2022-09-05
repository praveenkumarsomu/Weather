//
//  DisplayImageViewController.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import UIKit

/// Display image view on large view which support pinch and zoom.
class DisplayImageViewController: UIViewController {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var imageView: UIImageView!
	var imageName: String!
	override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
    }
	private func configureUI() {
		imageView.image = UIImage(named: imageName)
		scrollView.delegate = self
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 10.0
	}
}
extension DisplayImageViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
	  return imageView
	}
}
