//
//  SearchCityWeatherPresenter.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation

@MainActor
protocol SearchCityWeatherPresenterProtocol {
    func viewDidLoad()
    func searchCityWeatherBy(_ cityName: String)
    
    var view: SearchCityWeatherViewProtocol? { get set }
}

@MainActor
final class SearchCityWeatherPresenter: SearchCityWeatherPresenterProtocol {
    
    weak var view: SearchCityWeatherViewProtocol?
    
    func viewDidLoad() {
        if let searchedCityCoord = SearchedCityStorage.fetchSearchedCity() {
            self.view?.showLoader()
            searchWeather(lat: searchedCityCoord.lat, long: searchedCityCoord.long)
        }
    }
    
    func searchCityWeatherBy(_ cityName: String) {
        self.view?.showLoader()
        searchWeatherBy(cityName)
    }
}

private extension SearchCityWeatherPresenter {
    
    func searchWeatherBy(_ cityName: String) {
        guard let view else { return }
        let searchName = cityName.components(separatedBy: " ").joined(separator: "+") // this is a workaround for city names with spaces on it like New York, this is totally failable with other characters so far
        Task {
            do {
                guard let cityCoords = try await WeatherFetcher.fetchCoordsBy(searchName).first else { return }
                let weatherResult = try await WeatherFetcher.fetchWeather(lat: cityCoords.lat, long: cityCoords.lon)
                SearchedCityStorage.saveSearchedCity(SearchedCityCoord(lat: cityCoords.lat, long: cityCoords.lon))
                view.updateWeatherInfo(WeatherInfo(weatherResult))
                view.stopLoader()
            } catch {
                view.show(error: error.localizedDescription)
            }
        }
    }
    
    func searchWeather(lat: Double, long: Double) {
        guard let view else { return }
        Task {
            do {
                let weatherResult = try await WeatherFetcher.fetchWeather(lat: lat, long: long)
                view.updateWeatherInfo(WeatherInfo(weatherResult))
                view.stopLoader()
            } catch {
                view.show(error: error.localizedDescription)
            }
        }
    }
}
