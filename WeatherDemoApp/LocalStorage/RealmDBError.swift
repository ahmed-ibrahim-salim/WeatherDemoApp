//
//  RealmDBError.swift
//  WeatherDemoApp
//
//  Created by ahmed on 06/04/2024.
//

import Foundation

enum RealmDBError: LocalizedError {
    case addError
    case deleteError
    
    var localizedDescription: String {
        switch self {
        case .addError:
            return "Error happend while adding entity to local storage"
        case .deleteError:
            return "Error happend while deleting entity to local storage"
        }
    }
}
