//
//  LocationManager.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: (((lon: Double, lat: Double)) -> Void)?
    
    func getLocation(completion: (((lon: Double, lat: Double)) -> Void)?) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        manager.stopUpdatingLocation()
        completion?((lon: location.coordinate.longitude,
                     lat: location.coordinate.latitude))
    }
    
}

