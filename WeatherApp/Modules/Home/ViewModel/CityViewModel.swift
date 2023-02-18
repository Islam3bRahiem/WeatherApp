//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

class CityViewModel {
    
    var image: String
    var title: String
    var description: String
    var temperature: String
    var humidity: String
    var windspeed: String
    var weatherInformation: String
    
    init(_ model: WeatherResponseModel) {
        self.image = NetworkConstants.imageUrl + "\(model.weather?.first?.icon ?? "").png"
        self.title = "\(model.name ?? ""), \(model.sys?.country ?? "")"
        self.description = model.weather?.first?.main ?? ""
        let temperatureInCelsius = (model.main?.temp ?? 0) - 273.15
        self.temperature = "\(String(format: "%.0f", temperatureInCelsius)) °C"
        self.humidity = "\(model.main?.humidity ?? 0) %"
        self.windspeed = "\(model.wind?.speed ?? 0) km/h"
        self.weatherInformation = "Weather information for \(model.name ?? "") received on \n \(Date().currentDate())"
    }
    
}
