//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import Foundation
import Combine

final class WeatherViewModel: ObservableObject {
    
    var service: WeatherServiceProtocol
    var weatherList = [WeatherInfo]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var state: NetworkState = .initial
    
    var defaultLatitute: Double {
        return UserDefaults.standard.object(forKey: AppConstants.defaultLat) as? Double ?? 0
    }
    
    var defaultLongitude: Double {
        return UserDefaults.standard.object(forKey: AppConstants.defaultLon) as? Double ?? 0
    }
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func shouldGetDefaultCityWeather(_ searchText: String = "") {
        if searchText.isEmpty {
            if defaultLatitute != 0 && defaultLongitude != 0 {
                getWeather(lat: defaultLatitute, lon: defaultLongitude)
            }
        }
    }
    
    func getWeather(lat: Double, lon: Double) {
        state = .loading
        service.fetchWeather(lat: lat, lon: lon)
            .receive(on: RunLoop.main)
            .sink {[weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.state = .error
                    print(err.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: {[weak self] response in
                self?.weatherList = [WeatherInfo(model: response)]
                self?.state = .loaded
            }
            .store(in: &cancellables)
    }
    
    func getWeather(_ searchText: String) {
        shouldGetDefaultCityWeather(searchText)
        
        state = .loading
        service.fetchWeather(search: searchText)
            .receive(on: RunLoop.main)
            .sink {[weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.state = .error
                case .finished:
                    break
                }
            } receiveValue: {[weak self] response in
                self?.weatherList = [WeatherInfo(model: response)]
                UserDefaults.standard.set(response.coord.lat, forKey: AppConstants.defaultLat)
                UserDefaults.standard.set(response.coord.lon, forKey: AppConstants.defaultLon)
                self?.state = .loaded
            }
            .store(in: &cancellables)
    }
    
}
