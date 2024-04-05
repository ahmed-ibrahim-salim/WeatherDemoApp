//
//  WeatherInfoDetailVC.swift
//  WeatherDemoApp
//
//  Created by ahmed on 05/04/2024.
//

import UIKit

class WeatherInfoDetailVC: UIViewController {
    
    let cityWeatherInfo: CityRealmObject
    
    private var gradientView: CAGradientLayer?
    
    init(cityWeatherInfo: CityRealmObject) {
        self.cityWeatherInfo = cityWeatherInfo
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
