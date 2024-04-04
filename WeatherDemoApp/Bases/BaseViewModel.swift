//
//  BaseViewModel.swift
//  WeatherDemoApp
//
//  Created by ahmed on 02/04/2024.
//

import Foundation
import Combine

typealias VoidCallback = (() -> Void)

class BaseViewModel {
    var disposables = Set<AnyCancellable>()

    var showIndicator: VoidCallback!
    var hideIndicator: VoidCallback!
    
}
