//
//  CityRealmObject.swift
//  WeatherDemoApp
//
//  Created by ahmed on 05/04/2024.
//

import Foundation
import RealmSwift

/// london [weatherInfo 20-10-2024]
/// each city will have an array of weather history info
class CityRealmObject: Object, ObjectKeyIdentifiable {
    @Persisted var cityName: String
    @Persisted var weatherInfoList = List<FormattedCityWeatherModel>()

    convenience init(weatherInfoItem: FormattedCityWeatherModel) {
        self.init()
        
        self.weatherInfoList.append(weatherInfoItem)
        self.cityName = weatherInfoItem.cityName
    }

}
