//
//  Pokemon.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
// Detail

import Foundation

struct Pokemon: Hashable {
    let id: Int
    let name: String
    var imageURL: URL?

    init?(pokemon: NamedAPIResource) {
        guard let urlComponents = URLComponents(string: pokemon.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
            return nil
        }

        self.id = id
        self.name = pokemon.name
        self.imageURL = URL(string: APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? "")
    }


    static var preview: Pokemon = Pokemon(pokemon:NamedAPIResource(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))!

}
