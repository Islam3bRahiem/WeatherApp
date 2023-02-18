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
        case filter
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
        switch destination {
        case .filter:
//            let viewModel = FilterViewModel()
//            let scene = FilterViewController(viewModel: viewModel, coordinator: coordinator)
            let scene = UIViewController()
            return scene
        }
    }
}
