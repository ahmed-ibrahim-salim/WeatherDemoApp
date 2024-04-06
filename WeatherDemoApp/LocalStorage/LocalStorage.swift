//
//  LocalStorage.swift
//  WeatherDemoApp
//
//  Created by ahmed on 05/04/2024.
//

import RealmSwift

final class LocalStorageHelper {
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
    func addCityWeatherInfoToRealm(weatherInfo: FormattedCityWeatherModel) throws {
        
        /// if city is present in DB, then append history entity
        if let city = queryCityIsAlreadyAdded(weatherInfo).first {
            do {
                try? LocalStorageHelper.realm.write {
                    city.weatherInfoList.append(weatherInfo)
                }
            } catch {
                throw RealmDBError.addError
            }
            
            return
        }
        
        /// new city? then add the new city to DB
        let city = CityRealmObject(weatherInfoItem: weatherInfo)
        do{
            try? LocalStorageHelper.realm.write {
                LocalStorageHelper.realm.add(city)
            }
        } catch {
            throw RealmDBError.addError
        }
    }
    
    // MARK: Delete
    func deleteCity(_ cityInfo: CityRealmObject) throws {

        if let city = queryCityByName(cityInfo).first {
            do {
                try? LocalStorageHelper.realm.write {
                    // Delete the Todo.
                    LocalStorageHelper.realm.delete(city)
                }
            } catch {
                throw RealmDBError.deleteError
            }
        }
    }
}

// MARK: Private
extension LocalStorageHelper {

    private func queryCityByName(
        _ cityInfo: CityRealmObject
    ) -> Results<CityRealmObject> {
        
        let cities = LocalStorageHelper.realm.objects(CityRealmObject.self).where({
            $0.cityName == cityInfo.cityName
        })
                
        return cities
    }
    
    private func queryCityIsAlreadyAdded(
        _ weatherInfo: FormattedCityWeatherModel
    ) -> Results<CityRealmObject> {
        
        let cities = LocalStorageHelper.realm.objects(CityRealmObject.self).where({
            $0.cityName == weatherInfo.cityName
        })
                
        return cities
    }
}


