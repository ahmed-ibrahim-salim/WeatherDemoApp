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
    
    /// injecting dependencies
    init(weatherFetcher: WeatherFetchable) {
        self.weatherFetcher = weatherFetcher
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
                
                self.city.send(cityWeatherInfo.getFormattedCityWeatherModel())
            case.failure(let err):
                self.error.send(err)
            }
            
        }
        
    }
}
