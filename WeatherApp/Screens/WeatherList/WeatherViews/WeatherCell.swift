//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/19/23.
//

import SwiftUI

struct WeatherCell: View {
//    let weather: Weather
    var body: some View {
        VStack(spacing: 35) {
            cityWeather
            averageWeather
        }        
    }
    
    var cityWeather: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("San Jose")
                    .style(.medium)
                Text("9:14 AM")
                    .style(.small)
            }
            Spacer()
            Text("59")
                .style(.h2)
        }
    }
    
    var averageWeather: some View {
        HStack {
            Text("Partly cloudy")
                .style(.small)
            Spacer()
            Text("H: 58 L:51")
                .style(.small_bold)
        }
    }
}

struct WeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCell()
    }
}
