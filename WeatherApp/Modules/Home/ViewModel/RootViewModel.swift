//
//  RootViewModel.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol RootViewModelInputs {
    func fetchWatherFroCoreData()
    func fetchCityWeather(_ city: String)
}

protocol RootViewModelOutputs {
    var itemsList: BehaviorRelay<[CityViewModel]> { get }
    var navigateToCityDetails: PublishSubject<CityViewModel> { get }
}

class RootViewModel: BaseVieWModel, RootViewModelInputs, RootViewModelOutputs {
    
    //MARK: - Properties
    private let apiClient = HomeApiClient.shared

    
    //MARK: - Outputs
    var itemsList: BehaviorRelay<[CityViewModel]> = .init(value: [])
    var navigateToCityDetails: PublishSubject<CityViewModel> = .init()
    
    //MARK: - Inputs
    func fetchWatherFroCoreData() {
    }
    
    func fetchCityWeather(_ city: String) {
        isLoading.onNext(true)
        
        let parameters = [
            "appid": NetworkConstants.APIKey,
            "q": city
        ] as [String : Any]
        
        apiClient.fetchCityData(parameters)
            .subscribe { [weak self](response) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                    self.handleResponse(response)
                }
            } onError: { [weak self] (error) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                    self.showAlertMsg(error.localizedDescription)
                }
            } onCompleted: {
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                }
                print("OnComplete")
        }.disposed(by: disposeBag)
    }
    
    private
    func handleResponse(_ response: WeatherResponseModel) {
        if let msg = response.message, !msg.isEmpty {
            self.showAlertMsg(msg)
            return
        }
        let city = CityViewModel(response)
        self.navigateToCityDetails.onNext(city)
    }
        
}
