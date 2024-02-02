//
//  UserPokemon.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import Foundation

struct UserPokemon: Codable, Hashable {
    var id = UUID()
    let pokemon: Pokemon
    let nickname: String

    static var preview: UserPokemon = UserPokemon(
        pokemon: Pokemon(pokemon:NamedAPIResource(name: "bulbasaur",
                                                  url: "https://pokeapi.co/api/v2/pokemon/1/"))!,
        nickname: "Borkstar"
    )
}
