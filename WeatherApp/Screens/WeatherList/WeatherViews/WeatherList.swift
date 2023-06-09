//
//  WeatherList.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/19/23.
//

import SwiftUI

/// this view is responsible for showing the list of weather data for the searched city/state and favorite cities (in future)

struct WeatherList: View {
    @State var searchText = ""
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                applyGradient()
                VStack {
                    switch viewModel.state {
                    case .initial:
                        EmptyWeatherListView()
                    case .loading:
                        Text("Loading...")
                            .style(.h1, viewColor: .white)
                    case .loaded:
                        VStack {
                            ForEach(viewModel.weatherList) { weather in
                                WeatherCell(weather: weather)
                            }
                        }
                        .padding()
                        .background(Color(.link).opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        Spacer()
                    case .noResults:
                        ErrorView(title: "\(viewModel.noResultMessage) \(searchText)")
                    case .error:
                        ErrorView(title: viewModel.errorResultMessage)
                    }
                }
                .padding()
                .navigationTitle(Text("Weather"))
                .onAppear {
                    viewModel.shouldGetDefaultCityWeather()
                }
                
            }
        }
        .searchable(text: $searchText, prompt: "Search for a city/state in USA")
        .onChange(of: searchText, perform: { newValue in
            if newValue.isEmpty || viewModel.state == .noResults {
                viewModel.state = .initial
            }
        })
        .onSubmit(of: .search) {
            viewModel.getWeather(searchText)
        }
            
    }
        
}

struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherList()
    }
}
