//
//  WeatherList.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/19/23.
//

import SwiftUI

struct WeatherList: View {
    @State var searchText = ""
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                applyGradient()
                VStack {
                    TextField("Search", text: $searchText)
                        .frame(height: 40)
                        .padding(.horizontal, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    if viewModel.weatherList.isEmpty {
                        Spacer()
                        EmptyWeatherListView()
                        Spacer()
                    } else {
                        List(viewModel.weatherList) { weather in
                            WeatherCell(weather: weather)
                        }

                    }
                }.padding()
                
            }
            .navigationTitle(Text("Weather"))
            .onChange(of: searchText) { newValue in
                viewModel.getWeather(newValue)
            }
            .onAppear() {
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
        }
    }
}

struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherList()
    }
}
