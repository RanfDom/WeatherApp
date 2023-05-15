//
//  SearchCityWeatherViewController.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import UIKit

protocol SearchCityWeatherViewProtocol: AnyObject, ErrorHandling {
    func updateWeatherInfo(_ weatherInfo: WeatherInfo)
    func showLoader()
    func stopLoader()
}

final class SearchCityWeatherViewController: UIViewController {
    private let weatherInfoView: WeatherInfoView = {
        let weatherInfoView = WeatherInfoView(frame: .zero)
        weatherInfoView.translatesAutoresizingMaskIntoConstraints = false
        return weatherInfoView
    }()
    
    private var spinnerView: SpinnerView?
    
    private var presenter: SearchCityWeatherPresenterProtocol
    
    init(_ presenter: SearchCityWeatherPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Specific city weather"
        
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.placeholder = "Search by city name"
        searchBar.searchBar.delegate = self
        self.navigationItem.searchController = searchBar
        
        self.edgesForExtendedLayout = []
        
        setUpView()
        presenter.viewDidLoad()
    }
}

extension SearchCityWeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedText = searchBar.text else { return }
        searchBar.text = nil
        presenter.searchCityWeatherBy(searchedText)
    }
}

extension SearchCityWeatherViewController: SearchCityWeatherViewProtocol {
    func updateWeatherInfo(_ weatherInfo: WeatherInfo) {
        weatherInfoView.updateWith(weatherInfo)
        weatherInfoView.isHidden = false
    }
    
    func showLoader() {
        guard let spinnerView else {
            addSpinerView()
            return
        }
        
        spinnerView.start()
    }
    
    func stopLoader() {
        spinnerView?.stop()
    }
}

private extension SearchCityWeatherViewController {
    func setUpView() {
        self.view.addSubview(weatherInfoView)
        
        NSLayoutConstraint.activate([
            weatherInfoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            weatherInfoView.topAnchor.constraint(equalTo: self.view.topAnchor),
            weatherInfoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            weatherInfoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        weatherInfoView.isHidden = true
    }
    
    func addSpinerView() {
        let spinnerView = SpinnerView(frame: .zero)
        self.view.addSubview(spinnerView)
        
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinnerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            spinnerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            spinnerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            spinnerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        self.spinnerView = spinnerView
    }
}
