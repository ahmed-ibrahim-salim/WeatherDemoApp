//
//  SearchCityViewModel.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation
import Combine

class SearchCityViewModel: BaseViewModel {
    
    /// output
    let city = PassthroughSubject<FormattedCityWeatherModel, Never>()
    let error = PassthroughSubject<GenericServerErrorModel, Never>()
    
    /// service(s)
    private let weatherFetcher: WeatherFetchable
    private let localStorageHelper: LocalStorageHelper
    
    /// injecting dependencies
    init(weatherFetcher: WeatherFetchable,
         localStorageHelper: LocalStorageHelper) {
        self.weatherFetcher = weatherFetcher
        self.localStorageHelper = localStorageHelper
    }
    
}

// MARK: Api calls
extension SearchCityViewModel {
    func fetchWeatherInfo(_ city: String) {
        showIndicator()
        
        weatherFetcher.getWeatherInfo(forCity: city) { [unowned self] result in
            hideIndicator()
            
            switch result {
            case .success(let cityWeatherInfo):
                let city = cityWeatherInfo.getFormattedCityWeatherModel()
                self.city.send(city)
                
                /// add to DB
                self.localStorageHelper.addCityWeatherInfoToRealm(weatherInfo: city)
            case.failure(let err):
                self.error.send(err)
            }
            
        }
        
    }
}
