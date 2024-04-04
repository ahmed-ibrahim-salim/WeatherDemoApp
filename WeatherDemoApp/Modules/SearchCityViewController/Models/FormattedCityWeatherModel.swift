//
//  CityWeatherInternal.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation

struct FormattedCityWeatherModel {
    let cityName, temp, humidity, windSpeed, description, icon: String
    
    /// null object pattern, to reduce null checks everywhere in the codebase
    static func makeDefaultObject() -> FormattedCityWeatherModel {
        FormattedCityWeatherModel(
            cityName: "",
            temp: "",
            humidity: "",
            windSpeed: "",
            description: "",
            icon: ""
        )
    }
}
