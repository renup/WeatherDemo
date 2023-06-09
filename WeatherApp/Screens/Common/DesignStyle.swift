//
//  DesignStyle.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import Foundation
import SwiftUI

/// This is where we define all the design styles for the app
/// We can also define the text styles and colors here. At some point, if the app grows huge and there are growing number of styles, we should be able to manage the growing complexities in separate components/files.

enum Colors {
    case primaryText
    case whiteText
    
    func colorView() -> Color {
        switch self {
        case .primaryText:
            return .primary
        case .whiteText:
            return .white
        }
    }    
}

enum GradientType {
    case normal, error
}


enum TextStyle {
    case h1
    case h2
    case small
    case medium
    case medium_bold
    case small_bold
}

extension View {
    /// Set the pre-defined text style
    ///  Make sure you call foregroundColor before style() to set custom forgroundColor
    @ViewBuilder func style(_ textStyle: TextStyle, viewColor: Color = .primary) -> some View {
        switch textStyle {
        case .h1:
            self.font(.system(size: 24, weight: .heavy))
                .foregroundColor(viewColor)
        case .h2:
            self.font(.system(size: 20, weight: .bold))
                .foregroundColor(viewColor)

        case .medium:
            self.font(.system(size: 16, weight: .regular))
                .foregroundColor(viewColor)
        case .medium_bold:
            self.font(.system(size: 16, weight: .bold))
                .foregroundColor(viewColor)

        case .small:
            self.font(.system(size: 14, weight: .regular))
                .foregroundColor(viewColor)
        
        case .small_bold:
            self.font(.system(size: 14, weight: .bold))
                .foregroundColor(viewColor)
                .lineSpacing(0.14)
        }
    }
    
    @ViewBuilder func applyGradient(_ type: GradientType = .normal) -> some View {
        switch type {
        case .normal:
            LinearGradient(gradient: Gradient(colors: [.white, Color(.yellow), .orange, Color(.link)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
        case .error:
            LinearGradient(gradient: Gradient(colors: [.red, Color(.link), .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
        }
        
    }
}

