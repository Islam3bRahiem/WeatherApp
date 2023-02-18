//
//  UIBarButtonItem+Extension.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

extension UIBarButtonItem {

    static func customBarButtonItem(_ target: Any?, action: Selector, imageName: String, imageTintColor: UIColor? = nil) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = imageTintColor
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 70).isActive = true

        return menuBarItem
    }
}
