//
//  Weather.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/19/23.
//

import Foundation

struct Location: Codable {
    let name: String
    let country: String
    let state: String
    let lat: Double
    let lon: Double
}

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let timezone: Int
}

struct Weather: Codable {
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}
