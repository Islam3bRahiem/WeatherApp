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

class SearchCityViewModel: BaseVieWModel, SearchCityViewModelInputs, SearchCityViewModelOutputs {
    
    //MARK: - Properties
    
    
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
