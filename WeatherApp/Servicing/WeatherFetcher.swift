//
//  WeatherFetcher.swift
//  WeatherApp
//
//  Created by Ranfe on 5/14/23.
//

import Foundation

/*
    For now I've enabled arbitrary loads on the Info.plist, this could also be more speciffic and add domain cathalog
    to wrap sub domains in there.
 */

struct WeatherFetcher {
    /*
        Storing appKey within the code is not recommended at all. I would encrypt it and put it on a dedicated plits
     */
    private static let appKey = "d679b83d6f4999ebeb38301e17f8183a"
    
    enum WeatherFetcherError: Error {
            case invalidURL
        }
    
    /*
        I could unit test this by using response mocking
     */
    static func fetchWeather(lat: Double, long: Double) async throws -> WeatherResult {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&units=imperial&appid=\(appKey)") else {
            throw WeatherFetcherError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let weatherResult = try decoder.decode(WeatherResult.self, from: data)
        return weatherResult
    }
    
    static func fetchCoordsBy(_ cityName: String) async throws -> [CityCoord] {
        guard let url = URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName),US&limit=1&appid=\(appKey)") else {
            throw WeatherFetcherError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let cityCoords = try JSONDecoder().decode([CityCoord].self, from: data)
        return cityCoords
    }
}
