//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import Foundation

struct PokemonDetailsResponse: Decodable {
    let id: Int
    let name: String
    let abilities: [PokemonAbility]
    let stats: [PokemonStats]
    let moves: [PokemonMoves]
    let sprites: PokemonSprites
    let types: [PokemonType]
}

struct PokemonAbility : Decodable {
    let ability: NamedAPIResource
}

struct PokemonStats: Decodable {
    let stat: NamedAPIResource
    let baseStat: Int // The base value of the stat.
}

struct PokemonMoves: Decodable {
    let move: NamedAPIResource
}

struct PokemonSprites: Decodable {
    let other: OtherPokemonSprites
}

struct OtherPokemonSprites: Decodable {
    let officialArtwork: OfficialArtwork

    private enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Decodable {
    let frontDefault: String?
    let frontShiny: String?
}

struct PokemonType: Decodable {
    let slot: Int
    let type: NamedAPIResource
}

