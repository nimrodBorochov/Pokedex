//
//  PersistenceManager.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

protocol PersistenceProtocol {
    func updateWith(userPokemon: UserPokemon, actionType: PersistenceActionType)
    func retrieveUserPokemons() throws -> [UserPokemon]
    func save(userPokemons: [UserPokemon]) throws
}

struct PersistenceManager: PersistenceProtocol {

    static private let defaults = UserDefaults.standard

    enum Keys {
        static let userPokemons = "userPokemons"
    }

    func updateWith(userPokemon: UserPokemon, actionType: PersistenceActionType) {
        do {
            var userPokemons = try retrieveUserPokemons()
            switch actionType {
            case .add:
                userPokemons.append(userPokemon)

            case .remove:
                userPokemons.removeAll { $0.id == userPokemon.id }
            }

            try save(userPokemons: userPokemons)
        } catch {
            //TODO:: handle errors
            print(error)
        }
    }

    func retrieveUserPokemons() throws -> [UserPokemon] {
        guard let userPokemonsData = Self.defaults.object(forKey: Keys.userPokemons) as? Data else {
            // first time
            return []
        }

        let decoder = JSONDecoder()
        return try decoder.decode([UserPokemon].self, from: userPokemonsData)
    }

    func save(userPokemons: [UserPokemon]) throws {
        let encoder = JSONEncoder()
        let encodedUserPokemons = try encoder.encode(userPokemons)
        Self.defaults.set(encodedUserPokemons, forKey: Keys.userPokemons)
    }
}
