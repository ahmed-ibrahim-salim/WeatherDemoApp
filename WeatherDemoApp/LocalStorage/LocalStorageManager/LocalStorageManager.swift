//
//  LocalStorageManager.swift
//  WeatherDemoApp
//
//  Created by ahmed on 06/04/2024.
//

import Foundation
import Combine


class LocalStorageManager: LocalStorageManagerProtocol {
    
    static let shared = LocalStorageManager(helper: RealmStorageHelper()) // Realm as default
    private var localStorageHelper: LocalStorageProtocol
    
    /// outputs
    let cities = PassthroughSubject<Result<[LocalStorageCity], LocalStorageError>, Never>()
    private var disposables = Set<AnyCancellable>()

    private init(helper: LocalStorageProtocol) {
        self.localStorageHelper = helper
        observeOnCities()
    }
    
    private func observeOnCities() {
        localStorageHelper.cities.sink { [unowned self] result in
            cities.send(result)
        }.store(in: &disposables)
    }
    
    func changeLocalStorageType(_ localDb: LocalStorageProtocol) {
        localStorageHelper = localDb
    }
    
    func getCities() -> [LocalStorageCity] {
      return localStorageHelper.getCitiesData()
    }

    func addCity(_ weatherInfo: FormattedCityWeatherModel) throws {
        try localStorageHelper.addCityWeatherInfoToLocalStorage(weatherInfo: weatherInfo)
    }

    func deleteCity(by name: String) throws {
      try localStorageHelper.deleteCityFromLocalStorage(name)
    }
    
    func clearDatabase() throws {
        try localStorageHelper.clearDatabase()
    }

}
