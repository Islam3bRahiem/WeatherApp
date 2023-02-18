//
//  ActivityIndicatorPresenter.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

protocol ActivityIndicatorPresenter {
    var activityIndicator: UIActivityIndicatorView { get }
    func showIndicator()
    func hideIndicator()
}

extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showIndicator() {
        self.activityIndicator.style = .large
        self.activityIndicator.color = .black
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width / 2,
                                                y: UIScreen.main.bounds.height / 2)
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
}
