//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchCityViewControllerDelegate: AnyObject {
    func didSearchBarSearchButtonClicked(_ city: String)
}

class SearchCityViewController: BaseController<SearchCityViewModel> {

    @IBOutlet weak var searchBar: UISearchBar!{
        didSet {
            searchBar.delegate = self
        }
    }
    
    weak var delegate: SearchCityViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func bind(viewModel: SearchCityViewModel) {
        viewModel.output.searchForCity
            .subscribe { [weak self] (city) in
                guard let self = self,
                let city = city.element else { return }
                self.coordinator.dismiss {
                    self.searchBar.endEditing(true)
                    self.delegate?.didSearchBarSearchButtonClicked(city)
                }
        }.disposed(by: disposeBag)

        viewModel.output.dismissViewController
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.coordinator.dismiss(completion: nil)
            }.disposed(by: disposeBag)

    }

}

// MARK: - ...  search bar delegation
extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text else { return }
        viewModel.input.searchBarSearchButtonClicked(city)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.searchBarCancelButtonClicked()
    }
}
