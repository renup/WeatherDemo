//
//  ErrorView.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        ZStack {
            applyGradient(.error)
            VStack(spacing: 15) {
                Text("Oops!! something went wrong 😢")
                    .style(.h1, viewColor: .white)
                Text("Check back again later 🙏")
                    .style(.h2, viewColor: .white)
            }
            .padding()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
