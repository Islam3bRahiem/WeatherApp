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
        case addNewCity
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
        switch destination {
        case .addNewCity:
            let viewModel = SearchCityViewModel()
            let scene = SearchCityViewController(viewModel: viewModel, coordinator: coordinator)
            return scene
        }
    }
}
