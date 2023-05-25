//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import Foundation

struct WeatherInfo: Identifiable {
    let id = UUID()
    var name: String = ""
    var currentTemp: String = ""
    var description: String = ""
    var tempHigh: String = ""
    var tempLow: String = ""
    var iconURLString: String = ""
    var time: String = ""
    
    var model: WeatherResponse
    
    init(model: WeatherResponse) {
        self.model = model
        
        initialSetUp()
    }
    
    
    private mutating func initialSetUp() {
        nameString()
        iconString()
        currentTemperature()
        timeString()
        temperatureHigh()
        temperatureLow()
        weatherDescription()
    }
    
    mutating func nameString() {
        name = model.name
    }
    
    mutating func timeString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: model.timezone)
        
        let currentDate = Date()
        time = dateFormatter.string(from: currentDate)
    }
    
    mutating func iconString() {
        guard let weatherIcon = model.weather.first?.icon else { return }
        iconURLString = "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png"
    }
    
    mutating func currentTemperature() {
        currentTemp = "\(String(convertToFarenhite(model.main.temp)))°"
    }
    
    mutating func temperatureHigh() {
        tempHigh = "\(String(convertToFarenhite(model.main.temp_max)))°"
    }
    
    mutating func temperatureLow() {
        tempLow = "\(String(convertToFarenhite(model.main.temp_min)))°"
    }
    
    mutating func weatherDescription() {
        let temperatureFahrenheit = convertToFarenhite(model.main.feels_like)
        
        if temperatureFahrenheit < 32 {
            description = "Freezing"
        } else if temperatureFahrenheit < 50 {
            description = "Cold"
        } else if temperatureFahrenheit < 68 {
            description = "Mild"
        } else if temperatureFahrenheit < 86 {
            description = "Warm"
        } else {
            description = "Hot"
        }        
    }
    
    private func convertToFarenhite(_ double: Double) -> Double {
        let result = (double - 273.15) * 9 / 5 + 32
        return round(result * 100)/100
    }
    
}

extension WeatherInfo {
    static let mock = WeatherInfo(model: WeatherResponse(name: "Alameda", coord: Coord(lat: -122.5, lon: 22.6), main: Main(temp: 287.54, feels_like: 287.23, temp_min: 284.55, temp_max: 295.22), weather: [Weather(icon: "https://openweathermap.org/img/wn/04d@2x.png")], timezone: -25200))
}
