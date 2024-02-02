//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import Foundation

struct PokemonDetails {
    let id: Int
    let name: String
    let height: Int // The height of this Pokémon in decimeter.
    let weight: Int // The weight of this Pokémon in hectograms.
    let abilities: [String]
    let stats: [(name: String, rating: Int)]
    let moves: [String]
    var frontDefaultImageUrl: URL? = nil
    var frontShinyImageUrl: URL? = nil

    init(pokemonDetailsResponse: PokemonDetailsResponse) {
        self.id = pokemonDetailsResponse.id
        self.name = pokemonDetailsResponse.name
        self.height = pokemonDetailsResponse.height
        self.weight = pokemonDetailsResponse.weight
        self.abilities = pokemonDetailsResponse.abilities.compactMap { $0.ability.name }
        self.stats = pokemonDetailsResponse.stats.compactMap { ($0.stat.name, $0.baseStat) }
        self.moves = pokemonDetailsResponse.moves.compactMap { $0.move.name }

        if let frontDefault = pokemonDetailsResponse.sprites.other.officialArtwork.frontDefault {
            self.frontDefaultImageUrl = URL(string: frontDefault)
        }
        if let frontShiny = pokemonDetailsResponse.sprites.other.officialArtwork.frontShiny {
            self.frontShinyImageUrl = URL(string: frontShiny)
        }

    }

    static var preview: PokemonDetails = PokemonDetails(pokemonDetailsResponse: PokemonDetailsResponse(
        id: 1,
        name: "bulbasaur",
        height: 7,
        weight: 69,
        abilities: [
            PokemonAbility(ability: Ability(name: "overgrow")),
            PokemonAbility(ability: Ability(name: "chlorophyll")),
        ],
        stats: [
            PokemonStats(stat: NamedAPIResource(name: "hp", url: ""),
                         baseStat: 45),
            PokemonStats(stat: NamedAPIResource(name: "attack", url: ""),
                         baseStat: 49),
            PokemonStats(stat: NamedAPIResource(name: "defense", url: ""),
                         baseStat: 49),
            PokemonStats(stat: NamedAPIResource(name: "special-attack", url: ""),
                         baseStat: 65),
            PokemonStats(stat: NamedAPIResource(name: "special-defense", url: ""),
                         baseStat: 65),
            PokemonStats(stat: NamedAPIResource(name: "speed", url: ""),
                         baseStat: 45),
        ],
        moves: [
            PokemonMoves(move: NamedAPIResource(name: "razor-wind", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind1", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind2", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind3", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind4", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind5", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind6", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind7", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind8", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind9", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind10", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind11", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind12", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind13", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind14", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind15", url: "")),
            PokemonMoves(move: NamedAPIResource(name: "razor-wind16", url: "")),

        ],
        sprites: PokemonSprites(other: OtherPokemonSprites(officialArtwork: OfficialArtwork(
            frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
            frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/1.png")
        ))
    ))
}
