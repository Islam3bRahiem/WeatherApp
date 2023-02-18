//
//  DateExtension.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import Foundation

extension Date {
    func currentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_us")
        dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
