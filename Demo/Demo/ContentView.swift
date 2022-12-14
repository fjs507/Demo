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
                NavigationLink("Network Request View", destination: PokemonView())
                    .modifier(StandardNavigationLinkViewModifier())
                NavigationLink("Go to ViewA", destination: ViewA())
                    .modifier(StandardNavigationLinkViewModifier())
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}
