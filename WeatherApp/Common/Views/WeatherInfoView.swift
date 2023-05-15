//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation
import UIKit

@MainActor
final class WeatherInfoView: UIView {
    
    private let cityNameLabel: UILabel = {
        let cityNameLabel = UILabel()
        cityNameLabel.textAlignment = .center
        cityNameLabel.numberOfLines = 2
        cityNameLabel.adjustsFontSizeToFitWidth = true
        cityNameLabel.font = .boldSystemFont(ofSize: 25.0)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityNameLabel
    }()
    
    private let weatherIconView: UIImageView = {
        let weatherIconView = UIImageView()
        weatherIconView.translatesAutoresizingMaskIntoConstraints = false
        return weatherIconView
    }()
    
    private let mainDescription: UILabel = {
        let mainDescription = UILabel()
        mainDescription.textAlignment = .center
        mainDescription.numberOfLines = 0
        mainDescription.translatesAutoresizingMaskIntoConstraints = false
        mainDescription.font = .boldSystemFont(ofSize: 20.0)
        return mainDescription
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40.0),
            cityNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            cityNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        self.addSubview(mainDescription)
        
        NSLayoutConstraint.activate([
            mainDescription.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10.0),
            mainDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            mainDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            mainDescription.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        self.addSubview(weatherIconView)
        
        NSLayoutConstraint.activate([
            weatherIconView.topAnchor.constraint(equalTo: mainDescription.bottomAnchor, constant: 10.0),
            weatherIconView.heightAnchor.constraint(equalToConstant: 100.0),
            weatherIconView.widthAnchor.constraint(equalToConstant: 100.0),
            weatherIconView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(_ weatherInfo: WeatherInfo) {
        cityNameLabel.text = weatherInfo.cityName
        mainDescription.text = weatherInfo.temp + " | " + weatherInfo.main
        
        if let iconURL = weatherInfo.iconURL {
            self.weatherIconView.image = nil
            Task {
                do {
                    try await self.weatherIconView.imageFrom(iconURL)
                } catch {
                    print("Image download failed with error: \(error)")
                }
            }
        }
    }
}
