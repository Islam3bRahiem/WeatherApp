//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import Foundation

class CityViewModel {
    
    var title: String
    
    init(_ model: WeatherResponseModel) {
        self.title = "\(model.name ?? ""), \(model.sys?.country ?? "")"
    }
    
}
