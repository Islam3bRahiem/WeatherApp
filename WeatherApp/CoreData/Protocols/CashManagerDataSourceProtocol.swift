//
//  CashManagerDataSourceProtocol.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import Foundation

protocol CashManagerDataSourceProtocol {
    func getAllCities() async throws -> [CityViewModel]
    func saveCity(city: CityViewModel) async throws -> ()
    func delete(_ name: String) async throws -> ()
    func getAllCities(with name: String) async throws -> [CityViewModel]
}
