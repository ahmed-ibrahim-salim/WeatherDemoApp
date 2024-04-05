//
//  LocalStorage.swift
//  WeatherDemoApp
//
//  Created by ahmed on 05/04/2024.
//

import RealmSwift

class LocalStorageHelper {
    private static var realm = try! Realm()
    private static var instance = LocalStorageHelper()
    
    private init() {}
    
    static func getInstance() -> LocalStorageHelper {
        instance
    }
    
    static func getCities() -> Results<CityRealmObject> {
        return LocalStorageHelper
                .realm
                .objects(CityRealmObject.self)
                .sorted(by: \.cityName)
    }
    
    // MARK: Add
    /// add a city to local storage
    func addCityWeatherInfoToRealm(weatherInfo: FormattedCityWeatherModel) {
        
        /// if city is present in DB, then append history entity
        if let city = queryCityIsAlreadyAdded(weatherInfo).first {
            
            try? LocalStorageHelper.realm.write {
                city.weatherInfoList.append(weatherInfo)
            }
            
            return
        }
        
        /// new city? then add the new city to DB
        let city = CityRealmObject(weatherInfoItem: weatherInfo)
        
        try? LocalStorageHelper.realm.write {
            LocalStorageHelper.realm.add(city)
        }
    }
    
}

// MARK: Private
extension LocalStorageHelper {
    // query for videos an video inf
    private func queryCityIsAlreadyAdded(
        _ weatherInfo: FormattedCityWeatherModel
    ) -> Results<CityRealmObject> {
        
        let cities = LocalStorageHelper.realm.objects(CityRealmObject.self).where({
            $0.cityName == weatherInfo.cityName
        })
                
        return cities
    }
}
