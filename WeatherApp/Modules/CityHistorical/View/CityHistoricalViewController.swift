//
//  CityHistoricalViewController.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 19/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class CityHistoricalViewController: BaseController<CityHistoricalViewModel> {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.subscribeToActions()
        self.viewModel.input.getAllCities()
    }

    override func bind(viewModel: CityHistoricalViewModel) {
        viewModel.output.title
            .subscribe { [weak self] (title) in
            guard let self = self,
                  let title = title.element else { return }
                self.titleLbl.text = title
        }.disposed(by: disposeBag)
    }

    private
    func setupUI() {
        closeBtn.backgroundColor = .mainColor
        closeBtn.cornerRaduis = 20
        closeBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        configureTableView()
    }

    private
    func subscribeToActions() {
        closeBtn.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.coordinator.pop()
            }.disposed(by: disposeBag)
    }

    private
    func configureTableView(){
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = .separatorColor
        tableView.register(nibWithCellClass: HistoricalCell.self)
        
        viewModel.output.citiesList
            .bind(to: tableView.rx
                    .items(cellIdentifier: String(describing: HistoricalCell.self),
                           cellType: HistoricalCell.self)) { index, viewModel, cell in
                cell.bind(viewModel)
        }.disposed(by: disposeBag)
    }

}

// MARK: - ...  UITableView Delegate
extension CityHistoricalViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

