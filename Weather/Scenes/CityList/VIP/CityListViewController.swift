//
//  CityListViewController.swift
//  Weather
//
//  Created by Praveen Kumar Somu on 3/9/22.
//

import UIKit

/// Protocol for displaying result from the presenter
protocol CityListDisplayLogic: AnyObject {
	/// In case of `getCityList` API siuccess presenter calls this function and View controller will implement this and normally reloads the table view to display latest list of the cities on home screen.
	/// - Parameter cities: Response from presenter to display list of cities on view controller.
	func displayCityList(_ cities: CityListModel.ViewModel)
	/// In case if `getCityList` API fails presenter will call this to inform view controller about it, Normally view controller will display alert message or error screen to user.
	/// - Parameter error: Error type which gives more context about why API is failed.
	func displayErrorWhileFetchingCityList(_ error: WeatherAPIError)
}
/// This view controller is initial view controller of the app and displays the List of the cities
/// You can see weather information of the city by selecting the city from the list (Table view)
///
class CityListViewController: UIViewController {
	//MARK: Outlets
	@IBOutlet weak var tableView: UITableView!
	//MARK: Instance variables
	var interactor: CityListViewBusinessLogic!
	var displayedCities: CityListModel.ViewModel!
	var router: CityListRouterProtocol!
	let constants = Constants()
	
	//MARK: View life cycle methods
	override func awakeFromNib() {
		super.awakeFromNib()
		configure()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		Task.detached { [weak self] in
			/// In future if we need to pass any additional data to interactor to get city list should be added as a variables inside Request.
			let request = CityListModel.Request()
			await self?.interactor?.getCityList(request)
		}
	}
	//MARK: Private configuration
	/// This function initialises and resolves the mapping between View controller -> Interactor -> Presenter
	private func configure() {
		let interactor = CityListInteractor()
		let presenter = CityListPresenter()
		let router = CityListRouter()
		self.interactor = interactor
		interactor.presenter = presenter
		presenter.view = self
		self.router = router
		router.viewController = self
	}
	/// Perform basic UI tasks on view load like setting screen titles, etc.
	private func configureUI() {
		self.title = constants.weather
		self.navigationController?.navigationBar.prefersLargeTitles = true
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: constants.cityListCell)
		/// Add nav bar buttions
		let contactUsButton = UIBarButtonItem(title: constants.contactUs, style: .plain, target: self, action: #selector(contactUsButtonTapped))
		let galleryButton = UIBarButtonItem(title: constants.gallery, style: .plain, target: self, action: #selector(galleryButtonTapped))
		navigationItem.rightBarButtonItems = [contactUsButton, galleryButton]
	}
	@objc private func contactUsButtonTapped() {
		router.navigateToContactScreen()
	}
	@objc private func galleryButtonTapped() {
		router.navigateToGalleryScreen()
	}
}
//MARK: Presenter output
extension CityListViewController: CityListDisplayLogic {
	func displayCityList(_ response: CityListModel.ViewModel) {
		self.displayedCities = response
		tableView.reloadData()
	}
	func displayErrorWhileFetchingCityList(_ error: WeatherAPIError) {
		showAlertWithSingleButtonAction(title: constants.error, message: constants.cityListAPIFailureMessage, actionTitle: constants.okayButtonTitle, action: nil)
	}
}
//MARK: Table view data source
extension CityListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return displayedCities?.cities.count ?? 0
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: constants.cityListCell, for: indexPath)
		cell.textLabel?.text = displayedCities?.cities[safe: indexPath.row]?.name
		cell.accessoryType = .disclosureIndicator
		return cell
	}
}

//MARK: Table view delegate
extension CityListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		guard let selectedCity = displayedCities.cities[safe: indexPath.row] else {
			showAlertWithSingleButtonAction(title: constants.error, message: constants.selectedCityIsNotFound, actionTitle: constants.okayButtonTitle, action: nil)
			return
		}
		do {
			try router.displayWeatherDetails(for: selectedCity)
		} catch {
			showAlertWithSingleButtonAction(title: constants.error, message: constants.selectedCityIsNotFound, actionTitle: constants.okayButtonTitle, action: nil)
		}
	}
}
