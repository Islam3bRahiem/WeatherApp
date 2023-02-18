//
//  Navigator.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

enum NavigatorTypes {
    case push
    case present
    case presentWithNavigation
}

protocol Navigator {
    associatedtype Destination
    init(coordinator: Coordinator)
    var coordinator: Coordinator { get }
    func navigate(to destination: Destination, with navigationType: NavigatorTypes)
    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController
}

extension Navigator {
    func navigate(to destination: Destination,
                  with navigationType: NavigatorTypes = .push) {
        let viewController = self.viewController(for: destination, coordinator: coordinator)
        switch navigationType {
        case .push:
            coordinator.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            viewController.modalPresentationStyle = .overFullScreen
            UIApplication.topMostController().present(viewController, animated: true, completion: nil)
        case .presentWithNavigation:
            let newVC = self.viewController(for: destination, coordinator: coordinator)
            let nav = UINavigationController(rootViewController: newVC)
            nav.modalPresentationStyle = .overFullScreen
            UIApplication.topViewController()?.present(nav, animated: true, completion: nil)
        }
    }
}
