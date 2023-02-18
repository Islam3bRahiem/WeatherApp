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
}

protocol RootViewModelOutputs {
    var itemsList: BehaviorRelay<[CityViewModel]> { get }
}

class RootViewModel: BaseVieWModel, RootViewModelInputs, RootViewModelOutputs {
    
    //MARK: - Properties
    
    
    //MARK: - Outputs
    var itemsList: BehaviorRelay<[CityViewModel]> = .init(value: [])

    
    //MARK: - Inputs
    func fetchWatherFroCoreData() {

    }
        
}
