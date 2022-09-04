//
//  WeatherDetailsViewController.swift
//  WeatherTests
//
//  Created by Praveen Kumar Somu on 4/9/22.
//

import UIKit

protocol WeatherDetailsDisplayLogic: AnyObject {
	func displayWeatherDetails(_ viewModel: WeatherDetailsModel.ViewModel)
	func displayWeatherDetailsError()
}

class WeatherDetailsViewController: UIViewController {
	//MARK: Outlets
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	//MARK: Instanse variables
	let constants = Constants()
	var interactor: WeatherDetailsBusinessLogic!
	var city: CityListModel.ViewModel.City!
	/// Output from the weather details API
	var displayedWeatherDetails: WeatherDetailsModel.ViewModel?
	/// User can choose the in which degree type. Each time value changed will trigger api
	var degree: DegreeType = .celsius {
		didSet {
			getWeatherDetails()
		}
	}
	enum DegreeType: String {
		case fahrenheit = "f"
		case celsius = "c"
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		configure()
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
		getWeatherDetails()
    }
	private func getWeatherDetails() {
		let request = WeatherDetailsModel.Request(city: city, degree: degree.rawValue)
		activityIndicator.startAnimating()
		Task.detached { [weak self] in
			guard let self = self else { return }
			try await self.interactor.getWeatherDetails(request)
		}
	}
	private func configure() {
		let dataStore = WeatherAPI()
		let worker = WeatherDetailsWorker(weatherStore: dataStore)
		let interactor = WeatherDetailsInteractor(worker)
		self.interactor = interactor
		let presenter = WeatherDetailsPresenter()
		interactor.presenter = presenter
		presenter.view = self
	}
	private func configureUI() {
		title = city.name
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: constants.degree, style: .plain, target: self, action: #selector(showDegreeActionSheet))
		tableView.registerNib(cell: constants.weatherDetailsCell)
	}
	@objc private func showDegreeActionSheet() {
		let actionSheet = UIAlertController(title: "Degree", message: constants.chooseDegree, preferredStyle: .actionSheet)
		let celsiusAction = UIAlertAction(title: constants.celsius, style: .default) { [weak self] _ in
			self?.degree = .celsius
		}
		let fahrenheitAction = UIAlertAction(title: constants.fahrenheit, style: .default) { [weak self] _ in
			self?.degree = .fahrenheit
		}
		let cancelAction = UIAlertAction(title: constants.cancel, style: .cancel, handler: nil)
		actionSheet.addAction(celsiusAction)
		actionSheet.addAction(fahrenheitAction)
		actionSheet.addAction(cancelAction)
		actionSheet.popoverPresentationController?.sourceView = self.view
		navigationController?.present(actionSheet, animated: true)
	}
}

//MARK: Presenter output
extension WeatherDetailsViewController: WeatherDetailsDisplayLogic {
	func displayWeatherDetails(_ viewModel: WeatherDetailsModel.ViewModel) {
		activityIndicator.stopAnimating()
		self.displayedWeatherDetails = viewModel
		tableView.reloadData()
	}
	
	func displayWeatherDetailsError() {
		activityIndicator.stopAnimating()
		showAlertWithSingleButtonAction(title: constants.error, message: constants.weatherDetailsNotFound, actionTitle: constants.okayButtonTitle, action: nil)
	}
}

//MARK: Table view data source

extension WeatherDetailsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let _ = displayedWeatherDetails else {
			return 0
		}
		return 1
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let weatherDetailsCell = tableView.dequeueReusableCell(withIdentifier: constants.weatherDetailsCell) as? WeatherDetailsTableViewCell else {
			return UITableViewCell()
		}
		guard let viewModel = displayedWeatherDetails else {
			return UITableViewCell()
		}
		weatherDetailsCell.selectionStyle = .none
		weatherDetailsCell.configureUI(viewModel)
		return weatherDetailsCell
	}
}
