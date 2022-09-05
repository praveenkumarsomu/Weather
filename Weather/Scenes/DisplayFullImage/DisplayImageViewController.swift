//
//  DisplayImageViewController.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import UIKit

/// Display image view on large view which support pinch and zoom.
class DisplayImageViewController: UIViewController {
	//MARK: Outlets
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var imageView: UIImageView!
	//MARK: Instance variables
	/// name of the image that needs to be displayed. If we implement real API we can exchange with coredata id.
	var imageName: String!
	//MARK: View controller life cycle methods
	override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
    }
	//MARK: Private functions
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
