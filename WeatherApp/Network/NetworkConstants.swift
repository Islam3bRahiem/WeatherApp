//
//  NetworkConstants.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//


public class NetworkConstants {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    static let imageUrl = "https://openweathermap.org/img/w/"
    static let APIKey = "f5cb0b965ea1564c50c6f1b74534d823"
    static let ContentType = "application/json"
    static let Lang = "en"
    static let DeviceType = "IOS"
    
    public enum endpoint {
        case weather
        
        var url: String {
            switch self {
            case .weather:
                return baseUrl + "weather"
            }
        }
    }
}
