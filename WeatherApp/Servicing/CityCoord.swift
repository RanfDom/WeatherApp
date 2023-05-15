//
//  CityCoord.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation

struct CityCoords: Decodable {
    let results: [CityCoord]
}

struct CityCoord: Decodable {
    let name: String
    let lat: Double
    let lon: Double
}
