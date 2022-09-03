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
	func displayErrorWhileFetchingCityList(_ error: CityListModel.CityListError)
}
/// This view controller is initial view controller of the app and displays the List of the cities
/// You can see weather information of the city by selecting the city from the list (Table view)
///
class CityListViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	var interactor: CityListViewBusinessLogic?
	var displayedCities: CityListModel.ViewModel?
	override func awakeFromNib() {
		super.awakeFromNib()
		configure()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
		configureUI()
		Task.detached { [weak self] in
			await self?.interactor?.getCityList()
		}
	}
	/// This function initialises and resolves the mapping between View controller -> Interactor -> Presenter
	private func configure() {
		let interactor = CityListInteractor()
		let presenter = CityListPresenter()
		self.interactor = interactor
		interactor.presenter = presenter
		presenter.view = self
	}
	/// Perform basic UI tasks on view load like setting screen titles, etc.
	private func configureUI() {
		self.title = "Weather"
		self.navigationController?.navigationBar.prefersLargeTitles = true
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants().cityListCell)
	}
}
//MARK: Presenter output
extension CityListViewController: CityListDisplayLogic {
	func displayCityList(_ response: CityListModel.ViewModel) {
		self.displayedCities = response
		tableView.reloadData()
	}
	func displayErrorWhileFetchingCityList(_ error: CityListModel.CityListError) {
		
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
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants().cityListCell, for: indexPath)
		cell.textLabel?.text = displayedCities?.cities[safe: indexPath.row]?.name
		cell.accessoryType = .disclosureIndicator
		return cell
	}
}

//MARK: Table view delegate
extension CityListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
}
