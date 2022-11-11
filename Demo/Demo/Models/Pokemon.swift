//
//  Pokemon.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import Foundation

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
