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
    func showAlertMsg(_ message: String)
}


class BaseVieWModel: ViewModel {
    var disposeBag = DisposeBag()
    var isLoading: PublishSubject<Bool> = .init()
    var displayMessage: PublishSubject<String> = .init()
}

extension BaseVieWModel {
    func showAlertMsg(_ message: String) {
        let alertContoller = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertContoller.addAction(cancelAction)
        let top = UIApplication.topMostController()
        top.present(alertContoller, animated: true)
    }
}
