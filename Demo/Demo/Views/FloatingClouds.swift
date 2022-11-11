//
//  FloatingClouds.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import SwiftUI

struct FloatingClouds: View {
    // MARK: Constants
    let alignments: [Alignment] = [
        .bottomTrailing,
        .topTrailing,
        .bottomLeading,
        .topLeading
    ]
    let backgroundColor: Color = Color(red: 0.043, green: 0.467, blue: 0.494)
    let blur: CGFloat = 10
    let colors: [Color] = [
        Color(red: 0.000, green: 0.176, blue: 0.216, opacity: 80.0),
        Color(red: 0.408, green: 0.698, blue: 0.420, opacity: 0.61),
        Color(red: 0.541, green: 0.733, blue: 0.812, opacity: 0.7),
        Color(red: 0.525, green: 0.859, blue: 0.655, opacity: 0.45)
    ]
    let durations: [Double] = [
        20,
        2400,
        30,
        25
    ]
    let rotationStartDegrees: [Double] = [
        0,
        240,
        120,
        180
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                backgroundColor
                ZStack {
                    ForEach(0..<4) { index in
                        Cloud(alignment: alignments[index],
                              color: colors[index],
                              duration: durations[index],
                              proxy: proxy,
                              rotationStart: rotationStartDegrees[index])
                    }
                }
                .blur(radius: blur)
            }
            .ignoresSafeArea()
        }
    }
}
