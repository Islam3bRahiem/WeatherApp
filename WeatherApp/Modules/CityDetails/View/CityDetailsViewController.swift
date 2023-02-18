//
//  CityDetailsViewController.swift
//  WeatherApp
//
//  Created by Islam Rahiem on 18/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class CityDetailsViewController: BaseController<CityDetailsViewModel> {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var weatherInfo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribeToActions()
    }
    
    override func bind(viewModel: CityDetailsViewModel) {
        viewModel.cityObservable
            .subscribe { [weak self] (viewModel) in
                guard let self = self,
                      let viewModel = viewModel.element else { return }
                self.titleLbl.text = viewModel.title
                self.weatherImg.downloaded(from: viewModel.image)
                self.descriptionLbl.text = viewModel.description
                self.temperatureLbl.text = viewModel.temperature
                self.humidityLbl.text = viewModel.humidity
                self.windSpeedLbl.text = viewModel.windspeed
                self.weatherInfo.text = viewModel.weatherInformation
            }.disposed(by: disposeBag)
        
    }

    private
    func setupUI() {
        closeBtn.backgroundColor = .mainColor
        closeBtn.cornerRaduis = 20
        closeBtn.layer.maskedCorners = [.layerMaxXMaxYCorner]
        containerView.layer.cornerRadius = 45
    }
    
    private func subscribeToActions() {
        closeBtn.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.coordinator.dismiss(completion: nil)
            }.disposed(by: disposeBag)
    }
}


extension UIImageView {
    func downloaded(from url: String, contentMode mode: ContentMode = .scaleAspectFit) {
        let url = URL(string: url)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
    }
}

