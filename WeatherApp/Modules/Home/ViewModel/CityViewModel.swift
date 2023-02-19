//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

struct CityViewModel {
    var image: String
    var name: String
    var country: String
    var title: String
    var description: String
    var temperature: String
    var humidity: String
    var windspeed: String
    var weatherInformation: String
    var historicalDate: String
    
    init(_ model: WeatherResponseModel) {
        self.image = NetworkConstants.imageUrl + "\(model.weather?.first?.icon ?? "").png"
        self.name = model.name ?? ""
        self.country = model.sys?.country ?? ""
        self.title = "\(model.name ?? ""), \(model.sys?.country ?? "")".uppercased()
        self.description = model.weather?.first?.main ?? ""
        let temperatureInCelsius = (model.main?.temp ?? 0) - 273.15
        self.temperature = "\(String(format: "%.0f", temperatureInCelsius)) °C"
        self.humidity = "\(model.main?.humidity ?? 0) %"
        self.windspeed = "\(model.wind?.speed ?? 0) km/h"
        self.weatherInformation = "Weather information for \(model.name ?? "") received on \n \(Date().currentDate())"
        self.historicalDate = Date().currentDate()
    }
    
    init(image: String?, name: String?, country: String?, description: String?, temperature: String?, humidity: String?, windspeed: String?, weatherInformation: String?, historicalDate: String?) {
        self.image = image ?? ""
        self.name = name ?? ""
        self.country = country ?? ""
        self.title = "\(name ?? ""), \(country ?? "")".uppercased()
        self.description = description ?? ""
        self.temperature = temperature ?? ""
        self.humidity = humidity ?? ""
        self.windspeed = windspeed ?? ""
        self.weatherInformation = weatherInformation ?? ""
        self.historicalDate = historicalDate ?? ""
    }

    
}
