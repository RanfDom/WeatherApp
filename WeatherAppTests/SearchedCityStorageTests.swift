//
//  SearchedCityStorageTests.swift
//  WeatherAppTests
//
//  Created by Ranfe on 5/14/23.
//

import XCTest
@testable import WeatherApp

final class SearchedCityStorageTests: XCTestCase {
    
    func testFetchExistingPrevSeach() {
        let coords = SearchedCityCoord(lat: 100.1, long: 100.1)
        
        SearchedCityStorage.saveSearchedCity(coords)
        
        if let fetchCoords = SearchedCityStorage.fetchSearchedCity() {
            XCTAssertTrue((fetchCoords.lat == coords.lat)&&(fetchCoords.long == coords.long), "Coords doesn't match")
        } else {
            XCTFail("Coords not found")
        }
        
    }
    
    func testFetchNonExistingPrevSeach() {
        UserDefaults.standard.removeObject(forKey: "SearchedCityCoord")
        XCTAssertNil(SearchedCityStorage.fetchSearchedCity(), "Should not find any coords")
    }
}
