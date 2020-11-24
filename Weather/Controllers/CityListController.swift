//
//  CityListController.swift
//  Weather
//
//  Created by Калинин Артем Валериевич on 22.11.2020.
//

import UIKit

class CityListController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCities: [Weather] = []
    private var tableView = UITableView()
    private var cities = [Weather]()
    
    private var detailView = UIView()
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        setTableView()
        getData()
    }
    
    //MARK: - Methods
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите город"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func filterContentForSearchText(_ searchText: String, category: Weather? = nil) {
        filteredCities = cities.filter { (city: Weather) -> Bool in
            return (city.geo_object?.locality?.name?.lowercased().contains(searchText.lowercased()))!
        }
        
        view.addSubview(detailView)
        tableView.reloadData()
    }
    
    private func getData() {
        let arrayOfCities = GettingData.shared.getCities()
        arrayOfCities.forEach {
            Network.shared.getWeather(city: $0) { [weak self] (result) in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weather):
                        guard weather != nil else {return}
                        DispatchQueue.main.async {
                            self.cities.append(weather)
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func setDetail(with serach: Weather) {
        detailView = UIView(frame: view.bounds)
        detailView.backgroundColor = .black
        view.addSubview(detailView)
    }
    
    private func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(CityWeatherCell.self, forCellReuseIdentifier: CityWeatherCell.identifire)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        view.addSubview(tableView)
    }
}

//MARK: - Extensions
extension CityListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCities.count
        }
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherCell.identifire, for: indexPath) as? CityWeatherCell else {return UITableViewCell()}
        let searchingCity: Weather
        if isFiltering {
            searchingCity = filteredCities[indexPath.row]
            cell.setup(with: searchingCity)
        } else {
            searchingCity = cities[indexPath.row]
            cell.setup(with: searchingCity)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Удалить город") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            self.tableView.reloadData()
            return
        }
        deleteButton.backgroundColor = UIColor.systemPink
        return [deleteButton]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        if isFiltering {
            vc.gettingCity = filteredCities[indexPath.row]
        } else {
            vc.gettingCity = cities[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CityListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
