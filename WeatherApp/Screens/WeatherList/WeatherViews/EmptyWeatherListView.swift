//
//  EmptyWeatherListView.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import SwiftUI

struct EmptyWeatherListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack{
                Spacer()
                Image(systemName:"cloud.sun")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)
                Spacer()
            }
            
            Text("Welcome to viewing weather in your city.")
                .style(.h1, viewColor: .white)
            Text("Feel free to enter a city in search field above")
                .style(.h2, viewColor: .white)
        }
        .padding()
    }
}

struct EmptyWeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyWeatherListView()
    }
}
