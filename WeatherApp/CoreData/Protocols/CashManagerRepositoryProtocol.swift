//
//  CashManagerRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import Foundation

enum ErrorResponse: Error{
    case DataSourceError, CreateError, DeleteError, FetchError, DeleteAllError
}

protocol CashManagerRepositoryProtocol {
    func getAllCities() async -> Result<[CityViewModel], ErrorResponse>
    func saveCity(_ city: CityViewModel) async -> Result<Bool, ErrorResponse>
    func deleteCity(_ name: String) async -> Result<Bool, ErrorResponse>
    func getAllCities(with name: String) async -> Result<[CityViewModel], ErrorResponse>
}

