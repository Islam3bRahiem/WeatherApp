//
//  NetworkObservable.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import RxSwift
import RxCocoa

public class NetworkObservable {
        
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    
    init(_ config: URLSessionConfiguration = .default) {
        self.urlSession = URLSession(configuration: config)
    }
    
    func callAPI<T: Decodable>(_ request: URLRequest) -> Observable<T> {
        return Observable<T>.create { observable in
            let task = self.urlSession.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    do {
                        if (200...399).contains(statusCode) {
                            //Handle Success Response
                            let object = try self.jsonDecoder.decode(T.self, from: data ?? Data())
                            observable.onNext(object)
                        } else if (400...499).contains(statusCode) {
                            //Handle badRequest Response
                            let object = try self.jsonDecoder.decode(T.self, from: data ?? Data())
                            observable.onNext(object)
                        } else {
                            print("ERROR....!")
                            if let error = error {
                                observable.onError(error)
                            }
                        }
                    } catch {
                        observable.onError(error)
                    }
                } else {
                    observable.onError(error!)
                }
                observable.onCompleted()
            }
            task.resume()
            return Disposables.create()
        }
        
    }
    
}
