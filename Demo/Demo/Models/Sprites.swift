//
//  Sprites.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import Foundation

struct Sprites: Codable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
