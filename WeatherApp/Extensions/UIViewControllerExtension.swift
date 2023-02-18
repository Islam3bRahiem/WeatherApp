//
//  UIViewControllerExtension.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

extension UIViewController {
    func topColouredBlack(with color: UIColor = .black) {
        let colouredTopBlack = UIView()
        view.addSubview(colouredTopBlack)
        colouredTopBlack.translatesAutoresizingMaskIntoConstraints = false
        colouredTopBlack.backgroundColor = color
        
        NSLayoutConstraint.activate([
            colouredTopBlack.topAnchor.constraint(equalTo: view.topAnchor),
            colouredTopBlack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colouredTopBlack.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}
