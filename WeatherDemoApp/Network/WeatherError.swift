//
//  WeatherError.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation
import Alamofire

enum WeatherError: Error {
    case parsing(description: String)
    case network(description: String)
    case custom(description: String)

    var localizedDescription: String {
        switch self {
        case .network(let value):   
            return value
        case .parsing(let value):   
            return value
        case .custom(let value):    
            return value
        }
    }
}
