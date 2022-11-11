//
//  PokeAPI.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import Foundation

struct PokeAPI {
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
