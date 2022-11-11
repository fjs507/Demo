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
                NavigationLink("Network Request", destination: PokemonView())
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
                .modifier(customViewModifier(
                    roundedCornes: 6,
                    startColor: .mint,
                    endColor: .blue,
                    textColor: .white))
                Spacer()
                PokemonButton(imageToDisplay: $imageToDisplay,
                              pokemonName: $pokemonName)
                Spacer()
                PokemonImage(image: $imageToDisplay)
                Spacer()
            }.padding()
        }.onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct PokemonButton: View {
    @Binding var imageToDisplay: Image?
    @Binding var pokemonName: String
    @State private var showingAlert = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        Button(action: {
            requestPokemon()
        }, label: {
            Text("Request \(pokemonName)")
                .frame(width: UIScreen.main.bounds.width / 2.0,
                       height: UIScreen.main.bounds.height / 20.0)
        })
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .buttonStyle(.bordered)
        .tint(.mint)
    }
    
    func requestPokemon() {
        print("\(#function)")
        Task {
            print("\(#line)")
            let (data, _, error) = await NetworkRequests.requestPokemon(pokemonName)
            print("\(#line)")
            if let error = error {
                print("\(#line)")
                showingAlert = true
                print("* ERROR \(#line), \(error), \(error.localizedDescription)")
                alertMessage = "Error with request: " + error.localizedDescription
            }
            if let data = data {
                print("\(#line)")
                do {
                    print("\(#line)")
                    let pokemon: Pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    print("* Pokemon, \(pokemon)")
                    downloadImage(from: URL(string: pokemon.sprites.frontDefault)!)
                } catch let error {
                    print("* ERROR \(#line), \(error), \(error.localizedDescription)")
                    print("\(#line)")
                    alertMessage = "Error decoding pokemon: " + error.localizedDescription
                }
            }
        }
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageToDisplay = Image(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

struct PokemonImage: View {
    @Binding var image: Image?
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFit()
        } else {
            Color.clear
        }
    }
}

//import Foundation
//import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Image {
    /// Initializes a SwiftUI `Image` from data.
    init?(data: Data) {
        #if canImport(UIKit)
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
        #elseif canImport(AppKit)
        if let nsImage = NSImage(data: data) {
            self.init(nsImage: nsImage)
        } else {
            return nil
        }
        #else
        return nil
        #endif
    }
}

struct NetworkRequests {
    static func requestPokemon(_ pokemonName: String) async -> (Data?, URLResponse?, Error?) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonName.lowercased())")!
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return (data, response, nil)
        } catch let error {
            return (nil, nil, error)
        }
    }
}

struct Pokemon: Decodable {
    var baseExperience: Int
    var height: Int
    var id: Int
    var name: String
    var order: Int
    var sprites: Sprites
    var weight: Int
    
    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height
        case id
        case name
        case order
        case sprites
        case weight
    }
}

struct Sprites: Decodable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

