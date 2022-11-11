//
//  Cloud.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import SwiftUI

struct Cloud: View {
    // MARK: State
    @State var move = false
    @StateObject var provider = CloudProvider()
    
    // MARK: Constants
    let fullRotationDegrees: Double = 360
    let opacity: Double = 0.8
    
    // MARK: Properties
    let alignment: Alignment
    let color: Color
    let duration: Double
    let proxy: GeometryProxy
    let rotationStart: Double
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(height: proxy.size.height /  provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + fullRotationDegrees) )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .opacity(opacity)
            .onAppear {
                withOptionalAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                    move.toggle()
                }
            }
    }
}
