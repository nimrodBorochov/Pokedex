//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import Foundation

struct PokemonDetailsResponse: Codable {
    let name: String
    let height: Int // The height of this Pokémon in decimeter.
    let weight: Int // The weight of this Pokémon in hectograms.
    let abilities: [PokemonAbility]
    let stats: [PokemonStats]
    let moves: [PokemonMoves]
}

struct PokemonAbility : Codable
{
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct PokemonStats: Codable {
    let stat: NamedAPIResource
    let baseStat: Int // The base value of the stat.
}

struct PokemonMoves: Codable {
    let move: NamedAPIResource
}
