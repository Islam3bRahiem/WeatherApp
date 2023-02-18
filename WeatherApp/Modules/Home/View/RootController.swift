//
//  RootController.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class RootController: BaseTableViewController<RootViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchWatherFroCoreData()
    }
    
    private
    func tableViewConfiguration() {
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = .separatorColor
        self.tableView.dataSource = nil
        
        viewModel.itemsList.bind(to: tableView.rx.items(cellIdentifier: String(describing: CityCell.self),
                                                        cellType: CityCell.self)) { index, viewModel, cell in
            cell.bind(viewModel)
        }.disposed(by: disposeBag)
    }
    
    override func bind(viewModel: RootViewModel) {
        
    }
    
    @objc func addNewCityTapped() {
        coordinator.home.navigate(to: .addNewCity, with: .present)
    }
}

extension RootController {
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        
        //Title
        let itemslabel = UILabel()
        itemslabel.heightAnchor.constraint(equalToConstant: 53).isActive = true
        itemslabel.textAlignment = .center
        itemslabel.text = "CITIES"
        itemslabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            
        view.addSubview(itemslabel)
        
        itemslabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemslabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            itemslabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            itemslabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            itemslabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        //Right Bar Button
        let customButton = UIButton.init(type: .custom)
        // your customization here
        customButton.setTitle(" + ", for: .normal)
        customButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        customButton.backgroundColor = .mainColor
        customButton.cornerRaduis = 20
        customButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.addSubview(customButton)
        
        customButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            customButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            customButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            customButton.widthAnchor.constraint(equalToConstant: 75)
        ])
        customButton.addTarget(self, action: #selector(addNewCityTapped), for: .touchUpInside)

        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        55
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }    
}
