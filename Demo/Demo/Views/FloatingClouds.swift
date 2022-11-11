//
//  FloatingClouds.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import SwiftUI

struct FloatingClouds: View {
    let backgroundColor: Color = Color(red: 0.043, green: 0.467, blue: 0.494)
    let colorA: Color = Color(red: 0.000, green: 0.176, blue: 0.216, opacity: 80.0)
    let colorB: Color = Color(red: 0.408, green: 0.698, blue: 0.420, opacity: 0.61)
    let colorC: Color = Color(red: 0.541, green: 0.733, blue: 0.812, opacity: 0.7)
    let colorD: Color = Color(red: 0.525, green: 0.859, blue: 0.655, opacity: 0.45)
    
    @Environment(\.colorScheme) var scheme
    let blur: CGFloat = 10
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                backgroundColor
                ZStack {
                    Cloud(proxy: proxy,
                          color: colorA,
                          rotationStart: 0,
                          duration: 20,
                          alignment: .bottomTrailing)
                    Cloud(proxy: proxy,
                          color: colorB,
                          rotationStart: 240,
                          duration: 10,
                          alignment: .topTrailing)
                    Cloud(proxy: proxy,
                          color: colorC,
                          rotationStart: 120,
                          duration: 30,
                          alignment: .bottomLeading)
                    Cloud(proxy: proxy,
                          color: colorD,
                          rotationStart: 180,
                          duration: 25,
                          alignment: .topLeading)
                }
                .blur(radius: blur)
            }
            .ignoresSafeArea()
        }
    }
}
