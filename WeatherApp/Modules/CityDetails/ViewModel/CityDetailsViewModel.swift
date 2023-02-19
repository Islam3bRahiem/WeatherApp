//
//  CityDetailsViewModel.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol CityDetailsViewModelInputs {
}

protocol CityDetailsViewModelOutputs {
    var cityObservable: PublishSubject<CityViewModel> { get }
}

// MARK: - ... Protocol
protocol CityDetailsViewModelProtocol {
    var input: CityDetailsViewModelInputs { get set }
    var output: CityDetailsViewModelOutputs { get set }
}

class CityDetailsViewModel: BaseVieWModel, CityDetailsViewModelInputs, CityDetailsViewModelOutputs, CityDetailsViewModelProtocol {
    
    //MARK: - Properties
    var input: CityDetailsViewModelInputs {
        get { return self }
        set {}
    }
    
    var output: CityDetailsViewModelOutputs {
        get { return self }
        set {}
    }

    //MARK: - init
    init(_ cityViewModel: CityViewModel) {
        super.init()
        DispatchQueue.main.async {
            self.cityObservable.onNext(cityViewModel)
        }
    }

    
    //MARK: - Outputs
    var cityObservable: PublishSubject<CityViewModel> = .init()

    
    //MARK: - Inputs
        
}
