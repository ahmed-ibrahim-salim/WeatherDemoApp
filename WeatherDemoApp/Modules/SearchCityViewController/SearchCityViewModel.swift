//
//  SearchCityViewModel.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation
import Combine

class SearchCityViewModel: BaseViewModel {
    
    let city = PassthroughSubject<CityWeatherInternal, Never>()
    let error = PassthroughSubject<WeatherError, Never>()

    private let weatherFetcher: WeatherFetchable
    
    init(weatherFetcher: WeatherFetchable) {
        self.weatherFetcher = weatherFetcher
        super.init()
        
    }
    
    func fetchWeatherInfo(_ city: String) {
     showIndicator()
      weatherFetcher.getWeatherInfo(forCity: city)
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
              hideIndicator()
            switch value {
            case let .failure(error):
                self.error.send(error)
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] cityWeatherInfo in
            guard let self = self else { return }
              hideIndicator()
              self.city.send(cityWeatherInfo.getCityWeatherInternal())
        })
        .store(in: &disposables)
    }
    
}
