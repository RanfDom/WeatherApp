//
//  WeatherTabViewController.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import UIKit

final class WeatherTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let ownWeatherViewControler = OwnWeatherViewController(OwnLocationPresenter())
        let ownWeatherNavigationController = UINavigationController(rootViewController: ownWeatherViewControler)
        ownWeatherNavigationController.navigationBar.barStyle = .default
        let ownWeatherTab = ownWeatherNavigationController
        let ownWeatherBarItem = UITabBarItem(title: "Own City", image: UIImage(systemName: "person"), selectedImage: nil)

        ownWeatherTab.tabBarItem = ownWeatherBarItem
        
        let searchCityWeatherViewControler = SearchCityWeatherViewController(SearchCityWeatherPresenter())
        let searchCityWeatherNavigationController = UINavigationController(rootViewController: searchCityWeatherViewControler)
        searchCityWeatherNavigationController.navigationBar.barStyle = .default
        let searchCityWeatherTab = searchCityWeatherNavigationController
        let searchCityWeatherBarItem = UITabBarItem(title: "Other City", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)

        searchCityWeatherTab.tabBarItem = searchCityWeatherBarItem
        
        self.viewControllers = [ownWeatherTab,searchCityWeatherTab]
    }
}
