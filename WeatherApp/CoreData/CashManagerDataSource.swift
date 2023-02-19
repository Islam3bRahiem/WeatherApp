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
                          title: item.title,
                          description: item.description,
                          temperature: item.temperature,
                          humidity: item.humidity,
                          windspeed: item.windspeed,
                          weatherInformation: item.weatherInformation)
        })
    }
    
    func saveCity(city: CityViewModel) async throws {
        let item = CityEntity(context: container.viewContext)
        item.id = UUID()
        item.image = city.image
        item.title = city.title
        item.desc = city.description
        item.temperature = city.temperature
        item.humidity = city.humidity
        item.windspeed = city.windspeed
        item.weatherInformation = city.weatherInformation
        saveContext()

    }
    

    func delete(_ id: UUID) async throws {
        let todoCoreDataEntity = try getEntityById(id)!
        let context = container.viewContext;
        context.delete(todoCoreDataEntity)
        
        do{
            try context.save()
        }catch{
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    //Private Functions
    private func getEntityById(_ id: UUID)  throws  -> CityEntity?{
        let request = CityEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "id = %@", id.uuidString)
        let context =  container.viewContext
        let todoCoreDataEntity = try context.fetch(request)[0]
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
