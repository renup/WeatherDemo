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
    @Published var weatherList = [WeatherInfo]()
    private var cancellables = Set<AnyCancellable>()
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func getWeather(_ searchText: String) {
        service.fetchWeather(search: searchText)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print(err.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: {[weak self] response in
                self?.weatherList = [WeatherInfo(model: response)]
            }
            .store(in: &cancellables)
    }
    
    
    
}
