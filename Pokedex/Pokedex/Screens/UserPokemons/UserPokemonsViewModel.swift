//
//  UserPokemonsViewModel.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import Foundation

@Observable class UserPokemonsViewModel {
    var pokemons: [UserPokemon] = []
    var persistenceManager: PersistenceProtocol = PersistenceManager()

    func getUserPokemons() {
        do {
            pokemons = try persistenceManager.retrieveUserPokemons()
        } catch {
            //TODO:: handle error
        }
    }

    func delete(_ indexSet: IndexSet) {
        indexSet.forEach { (index) in
            persistenceManager.updateWith(
                userPokemon: pokemons[index],
                actionType: .remove
            )
            pokemons.remove(at: index)
        }

    }

}
