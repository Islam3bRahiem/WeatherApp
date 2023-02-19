//
//  CashManagerRepository.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import Foundation

struct CashManagerRepository: CashManagerRepositoryProtocol {
    
    var dataSource: CashManagerDataSourceProtocol

    init() {
        self.dataSource = CashManagerDataSource()
    }

    func getAllCities() async -> Result<[CityViewModel], ErrorResponse> {
        do{
            let _todos =  try await dataSource.getAllCities()
            return .success(_todos)
        }catch{
            return .failure(.FetchError)
        }
    }
    
    func saveCity(_ city: CityViewModel) async -> Result<Bool, ErrorResponse> {
        do{
            try await dataSource.saveCity(city: city)
            return .success(true)
        }catch{
            return .failure(.CreateError)
        }
    }
    
    func deleteCity(_ id: UUID) async -> Result<Bool, ErrorResponse> {
        do{
            try await dataSource.delete(id)
            return .success(true)
        }catch{
            return .failure(.DeleteError)
        }
    }
    

}
