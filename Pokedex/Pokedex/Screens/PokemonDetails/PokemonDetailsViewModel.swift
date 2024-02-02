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

    var showShinny =  false


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

    func addToFavorites(_ nickname: String) {
        guard let pokemon else { return }
        PersistenceManager.updateWith(userPokemon: UserPokemon(pokemon: Pokemon(id: pokemon.id,
                                                                                name: pokemon.name,
                                                                                imageURL: pokemon.frontDefaultImageUrl),
                                                               nickname: nickname),
                                      actionType: .add) { error in
            if let error {
                print(error)
                //TODO:: handle errors
            }
        }
    }
}
