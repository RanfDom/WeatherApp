//
//  CurrentWeatherModels.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation

struct WeatherResult: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
}
