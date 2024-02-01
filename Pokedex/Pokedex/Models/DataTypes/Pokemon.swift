//
//  Pokemon.swift
//  PokTemp
//
//  Created by Nimrod Borochov on 01/02/2024.
// Detail

import Foundation

struct Pokemon: Hashable {
    let id: Int
    let name: String
    var imageURL: URL?

    init?(pokemonResponse: PokemonResponse) {
        guard let urlComponents = URLComponents(string: pokemonResponse.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
            return nil
        }

        self.id = id
        self.name = pokemonResponse.name
        self.imageURL = URL(string: APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? "")
    }


    static var preview: Pokemon = Pokemon(pokemonResponse:PokemonResponse(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))!

}
