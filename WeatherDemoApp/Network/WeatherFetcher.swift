//
//  WeatherFetcher.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import Foundation
import Alamofire
import Combine

protocol WeatherFetchable {
  func getWeatherInfo(forCity city: String) -> AnyPublisher<CityWeatherResponse, WeatherError>

}

class WeatherFetcher {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - WeatherFetchable
extension WeatherFetcher: WeatherFetchable {
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
    
    // return with a success Publisher
    return session.dataTaskPublisher(for: URLRequest(url: url))
      .mapError { error in
        .network(description: error.localizedDescription)
      }
      .flatMap(maxPublishers: .max(1)) { pair in
        decode(pair.data)
      }
      .eraseToAnyPublisher()
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
