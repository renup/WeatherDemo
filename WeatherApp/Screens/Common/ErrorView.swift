//
//  ErrorView.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    var body: some View {
        ZStack {
            applyGradient(.error)
            VStack(spacing: 15) {
                Text(title)
                    .style(.h1, viewColor: .white)
                    .minimumScaleFactor(0.5)
            }
            .padding()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: "Oops!! something went wrong 😢. Check back again later 🙏")
    }
}
