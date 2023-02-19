//
//  SearchCityViewModel.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchCityViewModelInputs {
    func searchBarSearchButtonClicked(_ city: String)
    func searchBarCancelButtonClicked()
}

protocol SearchCityViewModelOutputs {
    var dismissViewController: PublishSubject<Void> { get }
    var searchForCity: PublishSubject<String> { get }
}

// MARK: - ... Protocol
protocol SearchCityViewModelProtocol {
    var input: SearchCityViewModelInputs { get set }
    var output: SearchCityViewModelOutputs { get set }
}

class SearchCityViewModel: BaseVieWModel, SearchCityViewModelInputs, SearchCityViewModelOutputs, SearchCityViewModelProtocol {
    
    //MARK: - Properties
    var input: SearchCityViewModelInputs {
        get { return self }
        set {}
    }
    
    var output: SearchCityViewModelOutputs {
        get { return self }
        set {}
    }

    
    //MARK: - Outputs
    var dismissViewController: PublishSubject<Void>  = .init()
    var searchForCity: PublishSubject<String> = .init()

    
    //MARK: - Inputs
    func searchBarSearchButtonClicked(_ city: String) {
        self.searchForCity.onNext(city)
    }
    
    func searchBarCancelButtonClicked() {
        self.dismissViewController.onNext(())
    }
        
}
