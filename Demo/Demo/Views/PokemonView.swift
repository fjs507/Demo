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
                Text("Enter a Pokemon").font(.title)
                    .frame(maxHeight: .infinity)
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
                .frame(maxHeight: .infinity)
                PokemonButton(imageToDisplay: $imageToDisplay,
                              pokemonName: $pokemonName)
                .frame(maxHeight: .infinity)
                ImageOptional(image: $imageToDisplay)
                    .frame(maxHeight: .infinity)
            }.padding()
        }.onTapGesture {
            self.hideKeyboard()
        }
    }
}
