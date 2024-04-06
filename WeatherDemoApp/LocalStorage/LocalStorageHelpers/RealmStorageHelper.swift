//
//  RealmStorageHelper.swift
//  WeatherDemoApp
//
//  Created by ahmed on 05/04/2024.
//

import RealmSwift
import Combine

final class RealmStorageHelper: LocalStorageProtocol {
    private var realm = try! Realm()
    
    private var notificationToken: NotificationToken!
    private var citiesObservervable: Results<CityRealmObject>!

    /// outputs
    let cities = PassthroughSubject<Result<[LocalStorageCity], LocalStorageError>, Never>()
    
    init() {
        
        startObservingCities()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func getCitiesData() -> [LocalStorageCity] {
        
        return realm
            .objects(CityRealmObject.self)
            .sorted(by: \.cityName)
            .map{$0.getLocalStorageCity()}
    }

    // MARK: Add
    /// add a city to local storage
    func addCityWeatherInfoToLocalStorage(weatherInfo: FormattedCityWeatherModel) throws {
        
        /// if city is present in DB, then append history entity
        if let city = queryCityIsAlreadyAdded(weatherInfo).first {
            do {
                try? realm.write {
                    city.weatherInfoList.append(weatherInfo)
                }
            } catch {
                throw LocalStorageError.addError
            }
            
            return
        }
        
        /// new city? then add the new city to DB
        let city = CityRealmObject(weatherInfoItem: weatherInfo)
        do{
            try? realm.write {
                realm.add(city)
            }
        } catch {
            throw LocalStorageError.addError
        }
    }
    
    // MARK: Delete
    func deleteCityFromLocalStorage(_ cityName: String) throws {

        if let city = queryCityByName(cityName).first {
            do {
                try? realm.write {
                    // Delete the Todo.
                    realm.delete(city)
                }
            } catch {
                throw LocalStorageError.deleteError
            }
        }
    }
    
    // Delete All
    func clearDatabase() throws {
        let videosInfo = realm.objects(CityRealmObject.self)
        
        for videoInfo in videosInfo{
            do {
                try? realm.write {
                    // Delete the Todo.
                    realm.delete(videoInfo)
                }
            } catch {
                throw LocalStorageError.deleteError

            }
        }
    }
}

// MARK: Private
extension RealmStorageHelper {
    
    private func startObservingCities() {
        citiesObservervable = getCitiesObservable()
        /// initial
        cities.send(.success(getCitiesData()))

        notificationToken = citiesObservervable.observe { [unowned self] (changes: RealmCollectionChange) in
            
            switch changes {
            case .initial, .update:
                cities.send(.success(getCitiesData()))
            case .error:
                cities.send(.failure(LocalStorageError.observationError))
            }
        }
    }
    
    private func getCitiesObservable() -> Results<CityRealmObject> {
        
        return realm
                .objects(CityRealmObject.self)
                .sorted(by: \.cityName)
    }
    
    private func queryCityByName(
        _ cityName: String
    ) -> Results<CityRealmObject> {
        
        let cities = realm.objects(CityRealmObject.self).where({
            $0.cityName == cityName
        })
                
        return cities
    }
    
    private func queryCityIsAlreadyAdded(
        _ weatherInfo: FormattedCityWeatherModel
    ) -> Results<CityRealmObject> {
        
        let cities = realm.objects(CityRealmObject.self).where({
            $0.cityName == weatherInfo.cityName
        })
                
        return cities
    }
}


