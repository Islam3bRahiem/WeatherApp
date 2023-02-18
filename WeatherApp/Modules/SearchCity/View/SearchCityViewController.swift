//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit

class SearchCityViewController: BaseController<SearchCityViewModel> {

    @IBOutlet weak var searchBar: UISearchBar!{
        didSet {
            searchBar.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.endEditing(false)
    }
    
    
    override func bind(viewModel: SearchCityViewModel) {
        
    }

}

// MARK: - ...  search bar delegation
extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print("Search with : ", searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        coordinator.dismiss()
    }
}
