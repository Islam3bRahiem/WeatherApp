//
//  CityCell.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

class CityCell: UITableViewCell {
    
    let titleLbl = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        
        // Set any attributes of your UI components here.
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = UIFont.systemFont(ofSize: 20)
        
        // Add the UI components
        contentView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CityViewModel) {
        self.titleLbl.text = viewModel.title
    }


}
