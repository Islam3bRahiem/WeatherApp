//
//  BaseViewModel.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewModel {
    var disposeBag: DisposeBag { get }
    var isLoading: PublishSubject<Bool> { get }
    var displayMessage: PublishSubject<String> { get }
    func displayNoInternetConnectionError(_ message: String, completion: @escaping ()->())
}


class BaseVieWModel: ViewModel {
    var disposeBag = DisposeBag()
    var isLoading: PublishSubject<Bool> = .init()
    var displayMessage: PublishSubject<String> = .init()
}

extension BaseVieWModel {
    func displayNoInternetConnectionError(_ message: String, completion: @escaping ()->()) {
        let alertContoller = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .default) { _ in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertContoller.addAction(okAction)
        alertContoller.addAction(cancelAction)
        let top = UIApplication.topMostController()
        top.present(alertContoller, animated: true)
    }
}
