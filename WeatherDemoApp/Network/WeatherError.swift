//
//  WeatherError.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}
