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

enum PersistenceManager {

    static private let defaults = UserDefaults.standard

    enum Keys {
        static let userPokemons = "userPokemons"
    }

    static func updateWith(userPokemon: UserPokemon, actionType: PersistenceActionType, completed: @escaping (Error?) -> Void) {
        retrieveUserPokemons { result in
            switch result {
            case .success(let userPokemons):
                var retrieveUserPokemons = userPokemons

                switch actionType {
                case .add:
                    retrieveUserPokemons.append(userPokemon)

                case .remove:
                    retrieveUserPokemons.removeAll { $0.id == userPokemon.id }
                }

                completed(save(userPokemons: retrieveUserPokemons))

            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retrieveUserPokemons(completed: @escaping (Result<[UserPokemon], Error>) -> Void) {
        guard let userPokemonsData = defaults.object(forKey: Keys.userPokemons) as? Data else {
            // first time
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let userPokemons = try decoder.decode([UserPokemon].self, from: userPokemonsData)
            completed(.success(userPokemons))
        } catch {
            completed(.failure(error))
        }
    }

    static func save(userPokemons: [UserPokemon]) -> Error? {

        do {
            let encoder = JSONEncoder()
            let encodedUserPokemons = try encoder.encode(userPokemons)
            defaults.set(encodedUserPokemons, forKey: Keys.userPokemons)
            return nil
        } catch {
            return error
        }
    }
}
