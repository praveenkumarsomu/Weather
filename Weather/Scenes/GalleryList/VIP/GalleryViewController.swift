//
//  GalleryViewController.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 5/9/22.
//

import UIKit

/// Display out from presenter in `GalleryViewController`.
protocol GalleryDisplayLogic {
	/// Display list of images from API
	/// - Parameter viewModel: viewmodel object which contains image names.
	func displayImages(_ viewModel: GalleryModel.ViewModel)
	/// Display error on API error
	/// - Parameter error: error type
	func displayErrorOnFailure(_ error: GalleryAPIError)
}

class GalleryViewController: UIViewController {
	//MARK: Outlets
	@IBOutlet weak var collectionView: UICollectionView!
	//MARK: Instanse variables
	/// Interactor object to get list of images from API. As of now no real API is implemented.
	var interactor: GalleryBusinessLogic!
	var router: GalleryRouterProtocol!
	let constants = Constants()
	/// Displayed images in collection view. Output from the presenter is stored as local variable to reload collection view.
	var displayedImages: [String] = []
	//MARK: View controller life cycle methods
	override func awakeFromNib() {
		super.awakeFromNib()
		configure()
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
		getImages()
    }
	//MARK: Private configuration
	private func getImages() {
		let request = GalleryModel.Request()
		Task.detached { [weak self] in
			guard let self = self else { return }
			await self.interactor.getImages(request)
		}
	}
	/// Configure Presenter, Interactor, worker and router dependencies.
	private func configure() {
		let dataStore = GalleryLocalAPI()
		let worker = GalleryWorker(dataStore)
		let interactor = GalleryInteractor(worker)
		let presenter = GalleryPresenter()
		self.interactor = interactor
		interactor.presenter = presenter
		presenter.view = self
		let router = GalleryRouter()
		router.controller = self
		self.router = router
	}
	private func configureUI() {
		self.title = constants.gallery
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
}

//MARK: Collection view data source
extension GalleryViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// Display first ten images from response.
		return min(displayedImages.count, 10)
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GalleryCollectionViewCell.self), for: indexPath) as? GalleryCollectionViewCell else {
			return UICollectionViewCell()
		}
		let image = UIImage(named: displayedImages[safe: indexPath.item] ?? "")
		imageCell.configureUI(image)
		return imageCell
	}
}

//MARK: Collection view delegate
extension GalleryViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let imageName = displayedImages[safe: indexPath.item] else {
			return
		}
		/// Router throws error if not able to construct `DisplayImageViewController`.
		do {
			try router.displayFullSizeImage(imageName)
		} catch {
			showAlertWithSingleButtonAction(title: constants.error, message: constants.unableToDisplayFullImage, actionTitle: constants.okayButtonTitle, action: nil)
		}
	}
}

//MARK: Presenter output
extension GalleryViewController: GalleryDisplayLogic {
	func displayImages(_ viewModel: GalleryModel.ViewModel) {
		self.displayedImages = viewModel.images
		collectionView.reloadData()
	}
	func displayErrorOnFailure(_ error: GalleryAPIError) {
		showAlertWithSingleButtonAction(title: constants.error, message: constants.unableToFetchImages, actionTitle: constants.okayButtonTitle, action: nil)
	}
}
