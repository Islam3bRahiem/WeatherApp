//
//  CityHistoricalViewModel.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol CityHistoricalViewModelInputs {
    func getAllCities() 
}

protocol CityHistoricalViewModelOutputs {
    var title: PublishSubject<String?>  { get }
    var citiesList: BehaviorRelay<[CityViewModel]> { get }
}

// MARK: - ... Protocol
protocol CityHistoricalViewModelProtocol {
    var input: CityHistoricalViewModelInputs { get set }
    var output: CityHistoricalViewModelOutputs { get set }
}

class CityHistoricalViewModel: BaseVieWModel, CityHistoricalViewModelInputs, CityHistoricalViewModelOutputs, CityHistoricalViewModelProtocol {
    
    //MARK: - Properties
    var input: CityHistoricalViewModelInputs {
        get { return self }
        set {}
    }
    
    var output: CityHistoricalViewModelOutputs {
        get { return self }
        set {}
    }
    
    private var name: String = ""
    
    //CoreData Repository
    private var cashManagerRepository: CashManagerRepositoryProtocol
    private let coreDataSerialQueue = DispatchQueue(label: "com.coredata.dispatch.serial")

    
    //MARK: - init
    init(_ name: String,
         cashManagerRepository: CashManagerRepositoryProtocol = CashManagerRepository()) {
        self.name = name
        self.cashManagerRepository = cashManagerRepository
    }

    
    //MARK: - Outputs
    var title: PublishSubject<String?> = .init()
    var citiesList: BehaviorRelay<[CityViewModel]> = .init(value: [])

    
    //MARK: - Inputs
    func getAllCities() {
        self.title.onNext("\(self.name) Historical".uppercased())
        isLoading.onNext(true)
        self.coreDataSerialQueue.async() {
            Thread.sleep(forTimeInterval: 1)
            self.getAllOfflineCities()
        }
    }
    
    private
    func getAllOfflineCities() {
        Task.init {
            let items = await cashManagerRepository.getAllCities(with: self.name)
            switch items {
            case .success(let items):
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                    self.citiesList.accept(items)
                }
            case .failure(let error):
                print("ERROR : ", error)
            }
        }
    }
}

