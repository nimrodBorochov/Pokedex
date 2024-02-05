//
//  Mocks.swift
//  PokedexTests
//
//  Created by Nimrod Borochov on 04/02/2024.
//

import Foundation
@testable import Pokedex

final class MockNetworkClient: NetworkClientProtocol {
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokedex.Pokemon] {
        []
    }

    func fetchPokemon(id: Int) async throws -> Pokedex.PokemonDetails {
        PokemonDetails.preview
    }
}

final class MockPersistence: PersistenceProtocol {
    var updatePokemon: Pokedex.UserPokemon?
    var actionType: Pokedex.PersistenceActionType?

    func updateWith(userPokemon: Pokedex.UserPokemon, actionType: Pokedex.PersistenceActionType) {
        self.updatePokemon = userPokemon
        self.actionType = actionType
    }
    
    func retrieveUserPokemons() throws -> [Pokedex.UserPokemon] {
        []
    }
    
    func save(userPokemons: [Pokedex.UserPokemon]) throws {
    }
}
