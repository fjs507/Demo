//
//  GradientViewModifier.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import SwiftUI

struct GradientViewModifier: ViewModifier {
    var endColor: Color
    var roundedCornes: CGFloat
    var startColor: Color
    var textColor: Color

    func body(content: Content) -> some View {
        content
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                        .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
            .font(.custom("Open Sans", size: 25))

            .shadow(radius: 10)
    }
}
