//
//  CityCell.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func bind(_ viewModel: CityViewModel) {
        self.titleLbl.text = viewModel.title
    }

}
