//
//  WeatherList.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/19/23.
//

import SwiftUI

struct WeatherList: View {
    @State var searchText = ""
    @State var doneTyping = false
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                applyGradient()
                VStack {
                    HStack{
                        TextField("Search", text: $searchText)
                            .frame(height: 40)
                            .padding(.horizontal, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        Spacer()
                        
                        Button {
                            if doneTyping {
                                viewModel.state = .initial
                                searchText = ""
                            } else {
                                viewModel.getWeather(searchText)
                            }
                            doneTyping.toggle()

                        } label: {
                            Text(doneTyping ? "Clear" : "Done")
                                .style(.medium_bold, viewColor: .white)
                                .padding(10)
                                .background(.green)
                                .cornerRadius(15)
                        }
                    }
                        
                    Spacer()
                    
                    switch viewModel.state {
                    case .initial:
                        EmptyWeatherListView()
                    case .loading:
                        Text("Loading...")
                            .style(.h1, viewColor: .white)
                    case .loaded:
                        List(viewModel.weatherList) { weather in
                            WeatherCell(weather: weather)
                        }
                    case .error:
                        ErrorView()
                    }
                    Spacer()
                }.padding()
                
            }
            .navigationTitle(Text("Weather"))
            .onAppear {
                viewModel.shouldGetDefaultCityWeather()
            }
        }
    }
}

struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherList()
    }
}
