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
    var citiesList: BehaviorRelay<[CityViewModel]> { get }
    var navigateToCityDetails: PublishSubject<CityViewModel> { get }
}

class RootViewModel: BaseVieWModel, RootViewModelInputs, RootViewModelOutputs {
    
    //MARK: - Properties
    private let apiClient = HomeApiClient.shared

    //CoreData Repository
    private var cashManagerRepository: CashManagerRepositoryProtocol
    private let coreDataSerialQueue = DispatchQueue(label: "com.coredata.dispatch.serial")

    
    init(cashManagerRepository: CashManagerRepositoryProtocol = CashManagerRepository()) {
        self.cashManagerRepository = cashManagerRepository
    }
    
    
    //MARK: - Outputs
    var citiesList: BehaviorRelay<[CityViewModel]> = .init(value: [])
    var navigateToCityDetails: PublishSubject<CityViewModel> = .init()
    
    
    //MARK: - Inputs
    func fetchWatherFroCoreData() {
        isLoading.onNext(true)
        self.coreDataSerialQueue.async() {
            Thread.sleep(forTimeInterval: 1)
            self.getAllOfflineCities()
        }
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
    
    private func getAllOfflineCities() {
        Task.init {
            let items = await cashManagerRepository.getAllCities()
            switch items {
            case .success(let items):
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                    self.citiesList.accept(items)
                }
                print("branches get successfully")
            case .failure(let error):
                print("ERROR : ", error)
            }
        }
    }
    
    private
    func handleResponse(_ response: WeatherResponseModel) {
        if let msg = response.message, !msg.isEmpty {
            self.showAlertMsg(msg)
            return
        }
        let city = CityViewModel(response)
        self.navigateToCityDetails.onNext(city)
        
        //Cash Branches offline on coredata
        self.coreDataSerialQueue.async() {
            Thread.sleep(forTimeInterval: 1)
            self.saveCityToCoreData(city)
        }
    }
    
    private
    func saveCityToCoreData(_ city: CityViewModel) {
        Task.init {
            let newItem = await cashManagerRepository.saveCity(city)
            switch newItem {
            case .success( _):
                DispatchQueue.main.async {
                    self.fetchWatherFroCoreData()
                }
            case .failure(let error):
                print("Error : ", error.localizedDescription)
            }
        }
    }

        
}
