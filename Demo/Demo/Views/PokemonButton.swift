//
//  PokemonButton.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import SwiftUI

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
        Task {
            let (data, response, error) = await PokeAPI.requestPokemon(pokemonName)
            if let error = error {
                alertMessage = "Error with request: " + error.localizedDescription
                showingAlert = true
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 404 {
                    alertMessage = "The Pokemon \(pokemonName) does not exist. \n\nPlease try something else."
                    showingAlert = true
                    return
                }
            }
            if let data = data {
                do {
                    let pokemon: Pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    print("* Pokemon, \(pokemon)")
                    downloadImage(from: URL(string: pokemon.sprites.frontDefault)!)
                } catch let error {
                    alertMessage = "Error decoding pokemon: " + error.localizedDescription
                    showingAlert = true
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
