//
//  EmptyWeatherListView.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import SwiftUI
/// This view is shown when there is no weather data to show
struct EmptyWeatherListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack {
                Text("Welcome 😊")
                    .style(.h1, viewColor: .white)
                    .minimumScaleFactor(0.5)
                Text("Search for a city/state in USA above")
                    .style(.h2, viewColor: .white)
                    .minimumScaleFactor(0.5)
            }
            HStack{
                Spacer()
                Image(systemName:"cloud.sun")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding()
    }
}

struct EmptyWeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyWeatherListView()
    }
}
