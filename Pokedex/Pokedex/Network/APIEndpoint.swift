//
//  Constants.swift
//  PokTemp
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import Foundation

enum APIEndpoint {
    static let pokeApiURL = "https://pokeapi.co/api/v2/"
    static let pokeApiArtworkURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%d.png"
//    static let pokeApiTimeoutInterval: Double = 15.0

    static let pokeApiPokemonListLimit: Int = 20

    case getPokemonList(limit: Int, offset: Int)
    case getPokemonImage(id: Int)

    var url: URL? {
        switch self {
        case .getPokemonList(let limit, let offset):
            return URL(string: "\(APIEndpoint.pokeApiURL)pokemon?limit=\(limit)&offset=\(offset)")
        case .getPokemonImage(let id):
            return URL(string: String(format: APIEndpoint.pokeApiArtworkURL, id))
        }
    }
}
