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

class CityDetailsViewModel: BaseVieWModel, CityDetailsViewModelInputs, CityDetailsViewModelOutputs {
    
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
