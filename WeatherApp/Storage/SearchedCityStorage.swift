//
//  SearchedCityStorage.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation

struct SearchedCityCoord: Codable {
    let lat: Double
    let long: Double
}

struct SearchedCityStorage {
    private static let cityKey = "SearchedCityCoord"
    
    static func fetchSearchedCity() -> SearchedCityCoord? {
        guard let data = UserDefaults.standard.object(forKey: cityKey) as? Data else { return nil }
        return try? JSONDecoder().decode(SearchedCityCoord.self, from: data)
    }
    
    static func saveSearchedCity(_ searchedCityCoord: SearchedCityCoord) {
        if let encoded = try? JSONEncoder().encode(searchedCityCoord) {
            UserDefaults.standard.set(encoded, forKey: cityKey)
        }
    }
}
