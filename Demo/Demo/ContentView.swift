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

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

