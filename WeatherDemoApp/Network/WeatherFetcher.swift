//
//  WeatherFetcher.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation
import Alamofire
import Combine
import Reachability

protocol WeatherFetchable {
    func getWeatherInfo(forCity city: String) -> AnyPublisher<CityWeatherResponse, WeatherError>
    
}

// MARK: - WeatherFetchable
class WeatherFetcher: WeatherFetchable {
    let reachability = try? Reachability()

    
    func getWeatherInfo(forCity city: String) -> AnyPublisher<CityWeatherResponse, WeatherError> {
        return execute(with: makeWeatherInfoComponents(withCity: city))
    }
    
    private func execute<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, WeatherError> where T: Decodable {
        
        // return with url error
        guard let url = components.url else {
            let error = WeatherError.network(description: "Couldn't create URL")
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return AF.request(URLRequest(url: url))
            .publishDecodable(type: T.self)
            .value()
            .mapError { [unowned self] error in
                checkInternetConnection(error)
            }
            .eraseToAnyPublisher()
        
    }
    
    private func checkInternetConnection(_ error: AFError) -> WeatherError{
        // Check for internet connectivity
        if let reachability = self.reachability,
            reachability.connection != .unavailable {
            // You have a valid network connection
            return WeatherError.network(description: error.localizedDescription)

        } else {
            // No network connection
            
            return WeatherError.network(description: "Network connection appears to be offline")

        }
    }
}

extension WeatherFetcher {
    struct OpenWeatherAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let key = "4c6eb36cdcfd3de4bddb06d5b9b4b760"
    }
    
    func makeWeatherInfoComponents(withCity city: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/weather"
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key)
        ]
        
        return components
    }
}
