//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var home: HomeNavigator { get }
    var navigationController: UINavigationController? { get }
    func start()
    func dismiss()
    func pop()
}

class AppCoordinator: Coordinator {
    let window: UIWindow
        
    lazy var home: HomeNavigator = {
        return .init(coordinator: self)
    }()
    
    var navigationController: UINavigationController? {
        if let navigationController = UIApplication.topMostController() as? UINavigationController {
            return navigationController
        }
        return nil
    }
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start(){
        let viewModel = HomeViewModel()
        let scene = HomeViewController(viewModel: viewModel, coordinator: self)
        let nav = UINavigationController(rootViewController: scene)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        UIApplication.topMostController().dismiss(animated: true, completion: nil)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }

    
}
