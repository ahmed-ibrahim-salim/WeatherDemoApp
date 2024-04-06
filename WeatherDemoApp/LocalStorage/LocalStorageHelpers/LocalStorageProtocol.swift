//
//  LocalStorageHelperProtocol.swift
//  WeatherDemoApp
//
//  Created by ahmed on 06/04/2024.
//

import Foundation
import Combine

protocol LocalStorageProtocol {
    
    var cities: PassthroughSubject<Result<[LocalStorageCity], LocalStorageError>, Never> {get}
    
    
    func getCitiesData() -> [LocalStorageCity]
    func addCityWeatherInfoToLocalStorage(weatherInfo: FormattedCityWeatherModel) throws
    func deleteCityFromLocalStorage(_ cityName: String) throws
    
    func clearDatabase() throws
}