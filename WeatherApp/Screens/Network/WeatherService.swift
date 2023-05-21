//
//  WeatherService.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import Foundation
import Combine

/**
 //geo - https://api.openweathermap.org/geo/1.0/direct?q=alameda,ca,usa&limit=5&appid=d9b989c37bd0640006ce9d7350173842
 
 //lat lon - https://api.openweathermap.org/data/2.5/weather?lat=37.7652076&lon=-122.2416355&appid=d9b989c37bd0640006ce9d7350173842
 
 //icon url - https://openweathermap.org/img/wn/04d@2x.png
 */

enum NetworkError: Error {
    case invalidURL(_ urlString: String)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid url"
        }
    }
}

protocol WeatherServiceProtocol {
    func fetchWeather(search: String) -> Future<WeatherResponse, Error>
    func fetchWeather(lat: Double, lon: Double) -> Future<WeatherResponse, Error>
}

final class WeatherService: WeatherServiceProtocol {
    struct Constants {
        static let geoBaseURL = "https://api.openweathermap.org/geo/1.0/direct"
        static let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather(lat: Double, lon: Double) -> Future<WeatherResponse, Error> {
        return Future { promise in
            let weatherURLString = "\(Constants.weatherBaseURL)?lat=\(lat)&lon=\(lon)&appid=\(AppConstants.apiKey)"
            guard let weatherURL = URL(string: weatherURLString) else {
                promise(.failure(NetworkError.invalidURL(weatherURLString)))
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: weatherURL)
                .map { $0.data }
                .decode(type: WeatherResponse.self, decoder: JSONDecoder())
                .mapError { error in
                    return error as Error
                }
                .sink { completion in
                    switch completion {
                    case .failure(let err):
                        promise(.failure(err))
                    case .finished:
                        break
                    }
                } receiveValue: { weatherResponse in
                    promise(.success(weatherResponse))
                }
                .store(in: &self.cancellables)
        }
       
    }
    
    func fetchWeather(search: String) -> Future<WeatherResponse, Error> {
        return Future { [self] promise in
            let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            let geoURLString = "\(Constants.geoBaseURL)?q=\(encodedSearch)&limit=1&appid=\(AppConstants.apiKey)"
            
            guard let geoURL = URL(string: geoURLString) else {
                promise(.failure(NetworkError.invalidURL(geoURLString)))
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: geoURL)
                .map { $0.data }
                .decode(type: [Location].self, decoder: JSONDecoder())
                .compactMap { $0.first }
                .map {[weak self] location in
                    guard let self = self else { return }
                    self.fetchWeather(lat: location.lat, lon: location.lon)
                        .sink { completion in
                            switch completion {
                            case .failure(let err):
                                promise(.failure(err))
                            case .finished:
                                break
                            }
                        } receiveValue: { weatherResponse in
                            promise(.success(weatherResponse))
                        }
                        .store(in: &self.cancellables)
                        
                }
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let err):
                        promise(.failure(err))
                    case .finished:
                        break
                    }
                }, receiveValue: { _ in })
                .store(in: &cancellables)
        }
        
    }
    
    
}
