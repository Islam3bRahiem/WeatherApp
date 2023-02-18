//
//  HomeNavigator.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

class HomeNavigator: Navigator {
    var coordinator: Coordinator
    
    enum Destination {
        case addNewCity(SearchCityViewControllerDelegate)
        case CityDetails(CityViewModel)
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
        switch destination {
        case .addNewCity(let delegate):
            let viewModel = SearchCityViewModel()
            let scene = SearchCityViewController(viewModel: viewModel, coordinator: coordinator)
            scene.delegate = delegate
            return scene
            
        case .CityDetails(let cityViewModel):
            let viewModel = CityDetailsViewModel(cityViewModel)
            let scene = CityDetailsViewController(viewModel: viewModel, coordinator: coordinator)
            return scene
        }
    }
}
