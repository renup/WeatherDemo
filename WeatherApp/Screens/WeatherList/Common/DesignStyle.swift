//
//  DesignStyle.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/20/23.
//

import Foundation
import SwiftUI


enum Colors {
    case whiteText
    
    func colorView() -> ColorView {
        switch self {
        case .whiteText:
            return ColorView(color: .white)
        }
    }    
}

struct ColorView {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
}


enum TextStyle {
    case h1
    case h2
    case small
    case medium
    case small_bold
}

extension View {
    /// Set the pre-defined text style
    ///  Make sure you call foregroundColor before style() to set custom forgroundColor
    @ViewBuilder func style(_ textStyle: TextStyle, colorView: ColorView = Colors.whiteText.colorView()) -> some View {
        switch textStyle {
        case .h1:
            self.font(.system(size: 24, weight: .heavy))
                .foregroundColor(colorView.color)
        case .h2:
            self.font(.system(size: 20, weight: .bold))
                .foregroundColor(colorView.color)

        case .medium:
            self.font(.system(size: 16, weight: .regular))
                .foregroundColor(colorView.color)

        case .small:
            self.font(.system(size: 14, weight: .regular))
                .foregroundColor(colorView.color)
        
        case .small_bold:
            self.font(.system(size: 14, weight: .bold))
                .foregroundColor(colorView.color)
                .lineSpacing(0.14)
        }
    }
}

