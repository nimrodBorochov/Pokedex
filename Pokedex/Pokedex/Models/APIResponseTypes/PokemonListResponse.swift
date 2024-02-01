//
//  PokemonListResponse.swift
//  PokTemp
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResponse]
}
