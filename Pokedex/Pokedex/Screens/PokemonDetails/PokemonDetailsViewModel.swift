//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import Foundation

@Observable class PokemonDetailsViewModel {
    private let networkClient: NetworkClientProtocol
    var pokemon: PokemonDetails?

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }

    func loadPokemonDetails(by id: Int) async {
        do {
            self.pokemon = try await networkClient.fetchPokemon(id: id)
        } catch {
            print(error.localizedDescription)
        }
    }
}
