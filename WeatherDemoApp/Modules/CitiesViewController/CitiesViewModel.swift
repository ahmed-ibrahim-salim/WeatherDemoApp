//
//  CitiesViewModel.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation
import RealmSwift
import Combine

final class CitiesViewModel: BaseViewModel {
    
    /// outputs
    let realmDBError = PassthroughSubject<RealmDBError, Never>()
    let serverError = PassthroughSubject<GenericServerErrorModel, Never>()
    private var cities: Results<CityRealmObject>!

    /// callbacks
    var reloadTableView: VoidCallback!
    
    /// service(s)
    private let localStorageHelper: LocalStorageHelper
    private var notificationToken: NotificationToken!
    private var citiesObservervable: Results<CityRealmObject>!

    /// injecting dependencies
    init(localStorageHelper: LocalStorageHelper) {
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

        notificationToken = citiesObservervable.observe { [unowned self] (changes: RealmCollectionChange) in
            
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

extension CitiesViewModel {
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
    
    func deleteCity(_ indexPath: IndexPath) {
        let city = getCityFor(indexPath)
        do {
            try localStorageHelper.deleteCity(city)
        } catch {
            if let error = error as? RealmDBError {
                self.realmDBError.send(error)
            }
        }
    }
}
