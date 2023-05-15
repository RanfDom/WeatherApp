//
//  OwnLocationPresenter.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import CoreLocation

@MainActor
protocol OwnLocationPresenterProtocol {
    func viewDidLoad()
    
    var view: OwnWeatherViewProtocol? { get set }
}

@MainActor
final class OwnLocationPresenter: NSObject, OwnLocationPresenterProtocol {
    
    private let locationManager = CLLocationManager()
    
    weak var view: OwnWeatherViewProtocol?
    
    private var weatherInfo: WeatherInfo?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func viewDidLoad() {
        guard let view else { return }
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            view.setUpWeatherInfoView()
            view.showLoader()
            locationManager.requestLocation()
        } else if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else { // Authorization on unwanted status
            view.showMessageView()
        }
    }
}

extension OwnLocationPresenter: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let view else { return }
        if manager.authorizationStatus == .authorizedWhenInUse {
            view.setUpWeatherInfoView()
            view.showLoader()
            locationManager.requestLocation()
        } else {
            view.showMessageView()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first, let view else { return }
        
        Task {
            do {
                let weatherResult = try await WeatherFetcher.fetchWeather(lat: location.coordinate.latitude, long: location.coordinate.longitude)
                view.updateWeatherInfo(WeatherInfo(weatherResult))
                view.stopLoader()
            } catch {
                view.show(error: error.localizedDescription)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        view?.show(error: error.localizedDescription)
    }
}
