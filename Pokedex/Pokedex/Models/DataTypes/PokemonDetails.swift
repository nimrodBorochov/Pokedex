//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import Foundation

struct PokemonDetails {
    let name: String
    let height: Int // The height of this Pokémon in decimeter.
    let weight: Int // The weight of this Pokémon in hectograms.
    let abilities: [String]
    let stats: [(name: String, rating: Int)]
    let moves: [String]

    init(pokemonDetailsResponse: PokemonDetailsResponse) {
        self.name = pokemonDetailsResponse.name
        self.height = pokemonDetailsResponse.height
        self.weight = pokemonDetailsResponse.weight
        self.abilities = pokemonDetailsResponse.abilities.compactMap { $0.ability.name }
        self.stats = pokemonDetailsResponse.stats.compactMap { ($0.stat.name, $0.baseStat) }
        self.moves = pokemonDetailsResponse.moves.compactMap { $0.move.name }
    }
}
