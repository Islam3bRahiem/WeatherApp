//
//  NetworkConstants.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//


public class NetworkConstants {
    static let baseUrl = "hsttps://api.openweathermap.org/data/2.5/"
    static let APIKey = "f5cb0b965ea1564c50c6f1b74534d823"
    static let ContentType = "application/json"
    static let Lang = "en"
    static let DeviceType = "IOS"
    
    public enum endpoint {
        case weather
        case cityWeather(String)
        
        var url: String {
            switch self {
            case .weather:
                return baseUrl + "weather"
            case .cityWeather(let city):
                return baseUrl + "weather?q=\(city)"
            }
        }
    }
}
