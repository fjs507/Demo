//
//  PokemonView.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import SwiftUI

struct PokemonView: View {
    @State private var pokemonName: String = "ditto"
    @State private var imageToDisplay: Image? = nil
    
    var body: some View {
        ZStack {
            FloatingClouds()
            VStack {
                Spacer()
                Text("Enter a Pokemon").font(.title)
                Spacer()
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Enter a Pokemon", text: $pokemonName)
                        .textInputAutocapitalization(.never)
                }
                .modifier(GradientViewModifier(
                    endColor: .blue,
                    roundedCornes: 6,
                    startColor: .mint,
                    textColor: .white))
                Spacer()
                PokemonButton(imageToDisplay: $imageToDisplay,
                              pokemonName: $pokemonName)
                Spacer()
                ImageOptional(image: $imageToDisplay)
                Spacer()
            }.padding()
        }.onTapGesture {
            self.hideKeyboard()
        }
    }
}
