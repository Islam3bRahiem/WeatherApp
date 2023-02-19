//
//  CashManagerDataSource.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import CoreData

struct CashManagerDataSource: CashManagerDataSourceProtocol {
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError("Cannot Load Core Data Model")
            }
        }
    }

    func getAllCities() async throws -> [CityViewModel] {
        let request = CityEntity.fetchRequest()
        return try container.viewContext.fetch(request).map({ item in
            CityViewModel(image: item.image,
                          name: item.name,
                          country: item.country,
                          description: item.desc,
                          temperature: item.temperature,
                          humidity: item.humidity,
                          windspeed: item.windspeed,
                          weatherInformation: item.weatherInformation,
                          historicalDate: item.historicalDate)
        })
    }
    
    func saveCity(city: CityViewModel) async throws {
        let item = CityEntity(context: container.viewContext)
        item.image = city.image
        item.name = city.name
        item.country = city.country
        item.desc = city.description
        item.temperature = city.temperature
        item.humidity = city.humidity
        item.windspeed = city.windspeed
        item.weatherInformation = city.weatherInformation
        item.historicalDate = city.historicalDate
        saveContext()

    }
    

    func delete(_ name: String) async throws {
        let todoCoreDataEntity = try getEntityByName(name)!
        let context = container.viewContext;
        context.delete(todoCoreDataEntity)
        
        do{
            try context.save()
        }catch{
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func getAllCities(with name: String) async throws -> [CityViewModel] {
        let request = CityEntity.fetchRequest()
        let filterArray = try container.viewContext.fetch(request).filter({ $0.name == name })
        return filterArray.map({ item in
            CityViewModel(image: item.image,
                          name: item.name,
                          country: item.country,
                          description: item.desc,
                          temperature: item.temperature,
                          humidity: item.humidity,
                          windspeed: item.windspeed,
                          weatherInformation: item.weatherInformation,
                          historicalDate: item.historicalDate)
        })
    }

    
    //Private Functions
    private func getEntityByName(_ name: String)  throws  -> CityEntity?{
        let request = CityEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "name = %@", name)
        let context =  container.viewContext
        let todoCoreDataEntity = try? context.fetch(request)[0]
        return todoCoreDataEntity
    }
            
    private func saveContext(){
        let context = container.viewContext
        if context.hasChanges {
            do{
                try context.save()
            }catch{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    

}

//59F70624-D30C-47FC-BE65-A97F40F43797
