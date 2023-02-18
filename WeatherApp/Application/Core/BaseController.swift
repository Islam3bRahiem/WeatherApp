//
//  BaseController.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol Alertable {
    func displayMessage(_ message: String)
}


class BaseController<T: BaseVieWModel>: UIViewController, ActivityIndicatorPresenter {
    
    //MARK: - Properties
    var viewModel: T
    var coordinator: Coordinator

    lazy var disposeBag: DisposeBag = {
       return DisposeBag()
    }()
    var activityIndicator = UIActivityIndicatorView()
    
    
    //MARK: - Init
    init(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        bindStates()
    }
    
    
    //MARK: - Functions
    func bind(viewModel: T) {
        fatalError("Please ovveride bind function")
    }
    
    private func bindStates() {
        viewModel.isLoading
            .subscribe { [weak self] (isLoading) in
                guard let self = self,
                let isLoading = isLoading.element else { return }
                if isLoading {
                    //Show Loader
                    self.showIndicator()
                }
                else {
                    //hide Loader
                    self.hideIndicator()
                }
        }.disposed(by: disposeBag)
        
        viewModel.displayMessage.subscribe { [weak self] (message) in
            guard let self = self,
            let message = message.element else { return }
            self.displayMessage(message)
        }.disposed(by: disposeBag)
    }
}


extension BaseController: Alertable {
    func displayMessage(_ message: String) {
        let alertContoller = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertContoller.dismiss(animated: true)
        }
        alertContoller.addAction(okAction)
        self.present(alertContoller, animated: true)
    }
}
