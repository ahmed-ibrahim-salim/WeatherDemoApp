//
//  SearchCityViewModel.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation
import Combine
import RealmSwift

final class SearchCityViewModel: BaseViewModel {
    
    /// output
    let realmDBError = PassthroughSubject<RealmDBError, Never>()
    let serverError = PassthroughSubject<GenericServerErrorModel, Never>()
    private var cities: Results<CityRealmObject>!
    
    /// callbacks
    var reloadTableView: VoidCallback!
    
    /// service(s)
    private let weatherFetcher: WeatherFetchable
    private let localStorageHelper: LocalStorageHelper
    private var citiesObservervable: Results<CityRealmObject>!
    private var notificationToken: NotificationToken!
    
    /// injecting dependencies
    init(weatherFetcher: WeatherFetchable,
         localStorageHelper: LocalStorageHelper) {
        self.weatherFetcher = weatherFetcher
        self.localStorageHelper = localStorageHelper
        
        super.init()
        
        self.startObservingCities()
        
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    // MARK: Observing
    private func startObservingCities() {
        self.citiesObservervable = LocalStorageHelper.getCities()
        self.cities = LocalStorageHelper.getCities()
        
        notificationToken = citiesObservervable.observe { [unowned self] changes in
            
            switch changes {
            case .initial, .update:
                cities = LocalStorageHelper.getCities()
                reloadTableView()
            case .error:
                let weatherError = GenericServerErrorModel(weatherError: .custom(description: "Something went wrong"))
                self.serverError.send(weatherError)            }
        }
    }
}

// MARK: Searching
extension SearchCityViewModel {
    func startSearching(_ searchText: String?) {
        guard let searchText = searchText else {return}
        
        /// empt string ? then get all cities
        if searchText.isEmpty {
            cities = LocalStorageHelper.getCities()
            reloadTableView()
            return
        }
        
        /// has cities ? then filter with name
        let filteredCities = LocalStorageHelper.getCities().where {
            $0.cityName.contains(searchText, options: [])
        }
        
        cities = filteredCities
        reloadTableView()
        
    }
    
    func clickedSearchBtn(_ searchText: String?) {
        guard let searchText = searchText,
              !searchText.isEmpty else {return}
        // api
        fetchWeatherInfo(searchText)
    }
}

extension SearchCityViewModel {
    // MARK: Table Datasource
    func getCityNameFor(_ indexPath: IndexPath) -> String {
        getCityFor(indexPath).cityName
    }
    
    func getCitiesCount() -> Int {
        cities.count
    }
    
    func getCityFor(_ indexPath: IndexPath) -> CityRealmObject {
        cities[indexPath.row]
    }
}


// MARK: Api calls
extension SearchCityViewModel {
    private func fetchWeatherInfo(_ city: String) {
        showIndicator()
        
        weatherFetcher.getWeatherInfo(forCity: city) { [unowned self] result in
            hideIndicator()
            
            switch result {
            case .success(let cityWeatherInfo):
                let city = cityWeatherInfo.getFormattedCityWeatherModel()
                
                do {
                    /// add to DB
                    try self.localStorageHelper.addCityWeatherInfoToRealm(weatherInfo: city)
                    
                    /// update results list
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [unowned self] in
                        startSearching(city.cityName)
                    }
                    
                } catch {
                    if let error = error as? RealmDBError {
                        self.realmDBError.send(error)
                    }
                }
            case.failure(let err):
                self.serverError.send(err)
            }
            
        }
        
    }
}
