//
//  UIImageViewExtension.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String?, placeholder: Placeholder? = nil) {
        let removingPercentEncodingURL = url?.removingPercentEncoding
        let safeURL = removingPercentEncodingURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let imageURL = URL(string: safeURL ?? "")
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageURL, placeholder: placeholder)
    }
}

