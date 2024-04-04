//
//  CityWeatherInternal.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation

struct CityWeatherInternal {
    let cityName, temp, humidity, windSpeed, description, icon: String
    
    static func makeDefaultObject() -> CityWeatherInternal {
        CityWeatherInternal(
            cityName: "",
            temp: "",
            humidity: "",
            windSpeed: "",
            description: "",
            icon: ""
        )
    }
}
