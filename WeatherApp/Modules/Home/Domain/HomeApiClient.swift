//
//  HomeApiClient.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import RxSwift
import RxCocoa

class HomeApiClient {
    
    static let shared = HomeApiClient()
    private lazy var networkObservable = NetworkObservable()
    
    func fetchCityData(_ dic: [String: Any] = [:], method: HTTPMethodType = .Get) -> Observable<WeatherResponseModel> {
        var component = URLComponents(string: NetworkConstants.endpoint.weather.url)!
        component.queryItems = dic.compactMap ({ (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        })
        var request = URLRequest(url: component.url!)
        request.httpMethod = method.rawValue
        request.addValue(NetworkConstants.APIKey, forHTTPHeaderField: "API Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return networkObservable.callAPI(request)
    }
    
}
