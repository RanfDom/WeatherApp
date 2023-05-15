//
//  OwnWeatherViewController.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import UIKit

protocol OwnWeatherViewProtocol: AnyObject, ErrorHandling {
    func showMessageView()
    func setUpWeatherInfoView()
    func updateWeatherInfo(_ weatherInfo: WeatherInfo)
    func showLoader()
    func stopLoader()
}

final class OwnWeatherViewController: UIViewController {
    
    private var weatherInfoView: WeatherInfoView?
    private var locationStatusMessageView: LocationStatusMessageView?
    
    private var spinnerView: SpinnerView?
    
    private var presenter: OwnLocationPresenterProtocol
    
    init(_ presenter: OwnLocationPresenterProtocol) {
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
        self.navigationItem.title = "Weather at your city"
        self.edgesForExtendedLayout = []
        presenter.viewDidLoad()
    }
}

extension OwnWeatherViewController: LocationStatusMessageViewDelegate {
    func userDidSelectButton(locationStatusView: LocationStatusMessageView, button: UIButton) {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL,options: [:],completionHandler: nil)
    }
}

extension OwnWeatherViewController: OwnWeatherViewProtocol {
    func showMessageView() {
        let locationStatusMessageView = LocationStatusMessageView(frame: .zero)
        locationStatusMessageView.delegate = self
        locationStatusMessageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(locationStatusMessageView)
        
        NSLayoutConstraint.activate([
            locationStatusMessageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationStatusMessageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            locationStatusMessageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            locationStatusMessageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        self.locationStatusMessageView = locationStatusMessageView
    }
    
    func setUpWeatherInfoView() {
        if let locationStatusMessageView {
            UIView.animate(withDuration: 0.5) {
                locationStatusMessageView.isHidden = true
                locationStatusMessageView.removeFromSuperview()
            }
        }
        
        let weatherInfoView = WeatherInfoView(frame: .zero)
        weatherInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(weatherInfoView)
        
        NSLayoutConstraint.activate([
            weatherInfoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            weatherInfoView.topAnchor.constraint(equalTo: self.view.topAnchor),
            weatherInfoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            weatherInfoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        self.weatherInfoView = weatherInfoView
    }
    
    func updateWeatherInfo(_ weatherInfo: WeatherInfo) {
        weatherInfoView?.updateWith(weatherInfo)
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

private extension OwnWeatherViewController {
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
