//
//  ContentView.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Go to ViewA", destination: ViewA())
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Go Back")
                    .font(.title3)
                    .frame(height: 30)
                    .padding()
                NavigationLink("Go to ViewA", destination: ViewB())
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Go Back")
                    .font(.title3)
                    .frame(height: 30)
                    .padding()
            }
        }
    }
}

struct ViewA: View {
    var body: some View {
        ZStack {
            FloatingClouds()
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("This is view a")
            }
            .padding()
        }
    }
}

struct ViewB: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("This is view b")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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

struct Cloud: View {
    @StateObject var provider = CloudProvider()
    @State var move = false
    let proxy: GeometryProxy
    let color: Color
    let rotationStart: Double
    let duration: Double
    let alignment: Alignment
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(height: proxy.size.height /  provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360) )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .opacity(0.8)
            .onAppear {
                withOptionalAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                    move.toggle()
                }
            }
    }
}

class CloudProvider: ObservableObject {
    let offset: CGSize
    let frameHeightRatio: CGFloat
    
    init() {
        frameHeightRatio = CGFloat.random(in: 0.7 ..< 1.4)
        offset = CGSize(width: CGFloat.random(in: -150 ..< 150),
                        height: CGFloat.random(in: -150 ..< 150))
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

