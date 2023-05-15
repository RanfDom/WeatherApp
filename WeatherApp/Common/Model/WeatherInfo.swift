//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation

struct WeatherInfo {
    let cityName: String
    let iconURL: URL?
    let main: String
    let temp: String
}

extension WeatherInfo {
    init(_ weatherResult: WeatherResult) {
        self.cityName = weatherResult.name
        self.main = weatherResult.weather.first?.main ?? ""
        self.temp = "\(weatherResult.main.temp.rounded(.toNearestOrEven))ºF"
        
        if let iconId = weatherResult.weather.first?.icon,
           let iconURL = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png") {
            self.iconURL = iconURL
        } else {
            self.iconURL = nil
        }
    }
}
