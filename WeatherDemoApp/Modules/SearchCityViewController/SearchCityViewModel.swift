//
//  SearchCityViewModel.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation
import Combine

class SearchCityViewModel: BaseViewModel, ObservableObject {
    
    @Published var city = CityWeatherInternal.makeDefaultObject()
    
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
            case .failure:
                self.city = CityWeatherInternal.makeDefaultObject()
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] cityWeatherInfo in
            guard let self = self else { return }
              hideIndicator()
              self.city = cityWeatherInfo.getCityWeatherInternal()
              print(self.city.temp)
        })
        .store(in: &disposables)
    }
    
}
