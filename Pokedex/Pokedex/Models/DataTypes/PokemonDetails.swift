//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import Foundation

struct PokemonDetails: Equatable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let stats: [Stat]
    let moves: [Move]
    let primaryType: `Type`
    let secondaryType: `Type`?
    var frontDefaultImageUrl: URL? = nil
    var frontShinyImageUrl: URL? = nil

    init(pokemonDetailsResponse: PokemonDetailsResponse, abilities: [Ability], moves: [Move]) {
        self.id = pokemonDetailsResponse.id
        self.name = pokemonDetailsResponse.name

        self.abilities = abilities
        self.stats = pokemonDetailsResponse.stats.compactMap { Stat(name: $0.stat.name.replacingOccurrences(of: "special-", with: "Sp. ").capitalized, baseStat: $0.baseStat) }
        self.moves = moves

        self.primaryType = Type(rawValue: pokemonDetailsResponse.types.filter{ $0.slot == 1 }.first?.type.name ?? "")  ?? .unknown
        self.secondaryType = Type(rawValue: pokemonDetailsResponse.types.filter{ $0.slot == 2 }.first?.type.name ?? "")

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
        abilities: [
            PokemonAbility(ability: NamedAPIResource(name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/")),
            PokemonAbility(ability: NamedAPIResource(name: "chlorophyll", url: "https://pokeapi.co/api/v2/ability/34/")),
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
        )), types: [
            PokemonType(slot: 1, type: NamedAPIResource(name: "grass", url: "")),
            PokemonType(slot: 2, type: NamedAPIResource(name: "poison", url: "")),
        ]
    ),abilities: [Ability(abilityResponse: AbilityResponse(name: "overgrow",
                                                           effectEntries: [
                                                               EffectEntries(
                                                                   effect: "When this Pokémon has 1/3 or less of its HP remaining, its grass-type moves inflict 1.5× as much regular damage.",
                                                                   language: NamedAPIResource(
                                                                       name: "en",
                                                                       url: ""
                                                                   )
                                                               )
                                                           ]))],
                                                        moves: [Move(moveResponse: MoveResponse(name: "swords-dance", effectEntries: [
                                                            EffectEntries(
                                                                effect: "Raises the user's Attack by two stages.",
                                                                language: NamedAPIResource(
                                                                    name: "en",
                                                                    url: ""
                                                                )
                                                            )
                                                        ]))])
}
