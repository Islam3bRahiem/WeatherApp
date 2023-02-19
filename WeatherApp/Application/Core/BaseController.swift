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


class BaseController<T: BaseVieWModel>: UIViewController, SVProgressHUDPresenter {
    
    //MARK: - Properties
    var viewModel: T
    var coordinator: Coordinator
    
    //Background view
    private let bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Background")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()


    lazy var disposeBag: DisposeBag = {
       return DisposeBag()
    }()
    
    
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
        setupUI()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Functions
    func bind(viewModel: T) {
        fatalError("Please ovveride bind function")
    }
    
    private
    func setupUI() {
        topColouredBlack(with: .backgroundColor)
        self.view.backgroundColor = .backgroundColor
        view.addSubview(bgImageView)
        configureBackgroundConstraints()
    }
    
    // Set up your constraints, main one here is the top constraint
    private
    func configureBackgroundConstraints() {
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                             constant: 0).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                              constant: 0).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                            constant: 0).isActive = true
        bgImageView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                            multiplier: 0.4).isActive = true
        view.layoutIfNeeded()
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


class BaseTableViewController<T: BaseVieWModel>: UITableViewController, SVProgressHUDPresenter {

    //MARK: - Properties
    var viewModel: T
    var coordinator: Coordinator

    //Background view
    private let bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Background")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()

    lazy var disposeBag: DisposeBag = {
       return DisposeBag()
    }()
    
    
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
        setupUI()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Functions
    func bind(viewModel: T) {
        fatalError("Please ovveride bind function")
    }
    
    private
    func setupUI() {
        topColouredBlack(with: .backgroundColor)
        self.view.backgroundColor = .backgroundColor
        view.addSubview(bgImageView)
        configureBackgroundConstraints()
    }
    
    // Set up your constraints, main one here is the top constraint
    private
    func configureBackgroundConstraints() {
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                             constant: 0).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                              constant: 0).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                            constant: 0).isActive = true
        bgImageView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                            multiplier: 0.4).isActive = true
        view.layoutIfNeeded()
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


extension BaseTableViewController: Alertable {
    func displayMessage(_ message: String) {
        let alertContoller = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertContoller.dismiss(animated: true)
        }
        alertContoller.addAction(okAction)
        self.present(alertContoller, animated: true)
    }
}
