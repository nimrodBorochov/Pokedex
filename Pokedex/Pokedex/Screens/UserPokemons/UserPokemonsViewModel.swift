//
//  UserPokemonsViewModel.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import Foundation

@Observable class UserPokemonsViewModel {
    var pokemons: [UserPokemon] = []

    func getUserPokemons() {

        PersistenceManager.retrieveUserPokemons { [weak self] result in

            guard let self else { return }
            switch result {
            case .success(let userPokemons):
                self.pokemons = userPokemons
            case .failure(let failure): break
                //TODO:: handel
            }
        }
    }

    func delete(_ indexSet: IndexSet) {
        indexSet.forEach { (index) in
//            pokemons.remove(at: index)
            PersistenceManager.updateWith(userPokemon: pokemons[index],
                                          actionType: .remove) { [weak self] error in
                guard let self else { return }
                if let error {
                    //TODO:: handel
                } else {
                    pokemons.remove(at: index)
                }
            }
        }

    }

}
