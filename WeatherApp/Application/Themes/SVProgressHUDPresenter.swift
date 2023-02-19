//
//  SVProgressHUDPresenter.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit
import SVProgressHUD

protocol SVProgressHUDPresenter {
    func showIndicator()
    func hideIndicator()
}

extension SVProgressHUDPresenter where Self: UIViewController {
    
    func showIndicator() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}
