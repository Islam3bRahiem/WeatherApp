//
//  HistoricalCell.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import UIKit

class HistoricalCell: UITableViewCell {

    @IBOutlet weak var historicalDateLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func bind(_ viewModel: CityViewModel) {
        self.historicalDateLbl.text = viewModel.historicalDate
        self.temperatureLbl.text = "\(viewModel.description), \(viewModel.temperature)"
    }

}
